//
//  NetworkDispatcher.swift
//  ClaroVideoNetworking
//
//  Created by alonso.salcido on 10/5/18.
//  Copyright © 2018 amco. All rights reserved.
//


import Foundation

public class NetworkDispatcher: DispatcherProtocol {
  
  // MARK: - Configuration
  private var environment: Environment
  
  // Here you can use URLSession, Alamofire, AFNetworking
  var task: URLSessionTask?
  
  // MARK: - Init
  required public init(environment: Environment) {
    self.environment = environment
  }
  
  // MARK: - Public
  func cancel() {
    self.task?.cancel()
  }
  
  //MARK: - Fetch functions
  public func fetchSync(uri: String? = nil, request:RequestProtocol, baseParams: ServiceParameters?, completion: @escaping (Result<Response,NetworkError>) -> Void) ->  URLSessionDataTask? {
    let session = URLSession.shared
    var dataTask: URLSessionDataTask?
    
    if let urlRequest = getUrlRequest(for: uri, request: request, parameters: baseParams) {
      dataTask = session.dataTask(with: urlRequest, completionHandler: self.validateTask(request: request, completion: completion))
      dataTask?.resume()
      return dataTask
    } else {
      completion(.failure(NetworkError.errorForRecuestfailed()))
      return dataTask
    }
  }
  
  public func fetch(uri: String? = nil, request:RequestProtocol, baseParams: ServiceParameters?, completion: @escaping (Result<Response,NetworkError>) -> Void) {
    let session = URLSession.shared
    DispatchQueue.global(qos: .background).async {
      if let urlRequest = self.getUrlRequest(for: uri, request: request, parameters: baseParams) {
       self.task = session.dataTask(with: urlRequest, completionHandler: self.validateTask(request: request, completion: completion))
       self.task?.resume()
     } else {
       DispatchQueue.main.async {
         completion(.failure(NetworkError.errorForRecuestfailed()))
       }
     }
    }
  }
    
  public func fetch(uri:String,request:RequestProtocol? = nil,completion: @escaping (Result<Response,NetworkError>) -> Void) {
    DispatchQueue.global(qos: .background).async {
      let session = URLSession.shared
      do {
        // Get URL
        guard let url = URL(string: uri) else {throw NetworkError.errorForMissingURL()}
        //Get request
        
        var urlRequest: URLRequest? = nil
        if let requestProtocol = request {
          urlRequest = URLRequest(url: url, timeoutInterval: requestProtocol.timeoutInterval)
          //Add parameters
          try self.configureParameters(bodyParameters: requestProtocol.getBodyParameters(baseParameters: nil),
                                       bodyEncoding: .jsonEncoding,
                                       urlParameters: requestProtocol.getUrlParameters(baseParameters: nil),
                                       request: &urlRequest!)
        } else {
          urlRequest = URLRequest(url: url,
                                  cachePolicy: .reloadIgnoringLocalCacheData,
                                  timeoutInterval: 10.0)
          
          urlRequest?.httpMethod = HTTPMethod.get.rawValue
        }
        
        guard let taskRequest = urlRequest else {throw NetworkError.errorForMissingURL()}
        self.task = session.dataTask(with: taskRequest, completionHandler: self.validateTask(request: request, completion: completion))
      }catch {
        DispatchQueue.main.async {
          completion(.failure(NetworkError.errorForRecuestfailed()))
        }
      }
      self.task?.resume()
    }
  }
    
  public func fetchCustomPost(uri: String? = nil, request: RequestProtocol, baseParams: ServiceParameters?, completion: @escaping (Result<Response, NetworkError>) -> Void) {
    let session = URLSession.shared
    DispatchQueue.global(qos: .userInitiated).async {
      do {
        let urlRequest = try self.buildCustomRequestPost(uri: uri, from: request, baseParams: baseParams)
        self.task = session.dataTask(with: urlRequest, completionHandler: self.validateTask(request: request, completion: completion))
      } catch {
        DispatchQueue.main.async {
          completion(.failure(NetworkError.errorForRecuestfailed()))
        }
      }
      self.task?.resume()
    }
  }
    func fetchJavaScriptPost(from request: RequestProtocol, baseParams: ServiceParameters ,completion: @escaping (Result<Response,NetworkError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
          let session = URLSession.shared
          do {
            guard let url = self.setupURL(request: request) else {throw NetworkError.errorForMissingURL()}
            
            //Get request
            var urlRequest: URLRequest? = nil
            
            urlRequest = URLRequest(url: url, timeoutInterval: request.timeoutInterval)
            
            let bodyParameters = request.getBodyParameters(baseParameters: baseParams)
            
            urlRequest?.httpMethod = request.method.rawValue
            let param = bodyParameters?.description.replacingOccurrences(of: "[", with: "{").replacingOccurrences(of: "]", with: "}")
            let postData = param?.data(using: .utf8, allowLossyConversion: true)
            urlRequest?.httpBody = postData
            
            let headers = [
              "Content-Type": "application/javascript",
              "Cache-Control": "no-cache",
              "Accept-Encoding": "gzip, deflate",
              "cache-control": "no-cache"
            ]
            urlRequest?.allHTTPHeaderFields = headers
            self.deleteCookies()
            
            guard let taskRequest = urlRequest else {throw NetworkError.errorForMissingURL()}
            self.task = session.dataTask(with: taskRequest, completionHandler: self.validateTask(request: request, completion: completion))
          }catch {
            DispatchQueue.main.async {
              completion(.failure(NetworkError.errorForRecuestfailed()))
            }
          }
          self.task?.resume()
        }
    }
  
  public func fetchUriGet(uri: String, from request: RequestProtocol, baseParams: ServiceParameters? = nil,completion: @escaping (Result<Response,NetworkError>) -> Void) {
    
    DispatchQueue.global(qos: .userInitiated).async {
      let session = URLSession.shared
      do {
        // Get URL
        guard let url = self.setupURL(request: request) else {throw NetworkError.errorForMissingURL()}
        //Get request
        
        var urlRequest: URLRequest? = nil
        
        urlRequest = URLRequest(url: url, timeoutInterval: request.timeoutInterval)
        //Add parameters
        try self.configureParameters(bodyParameters: request.getBodyParameters(baseParameters: nil),
                                     bodyEncoding: .urlEncoding,
                                     urlParameters: request.getUrlParameters(baseParameters: baseParams),
                                     request: &urlRequest!)
        guard let taskRequest = urlRequest else {throw NetworkError.errorForMissingURL()}
        self.task = session.dataTask(with: taskRequest, completionHandler: self.validateTask(request: request, completion: completion))
      }catch {
        DispatchQueue.main.async {
          completion(.failure(NetworkError.errorForRecuestfailed()))
        }
      }
      self.task?.resume()
    }
  }
  
  //MARK: - URLRequest methods
  public func getUrlRequest(for uri:String?, request: RequestProtocol, parameters: ServiceParameters?) -> URLRequest? {
    let urlRequest = try? request.method == .get ? self.buildRequestGet(uri: uri, from: request, baseParams: parameters) : self.buildRequestPost(uri: uri, from: request, baseParams: parameters)
    return urlRequest
  }
  
  fileprivate func setupURL(request: RequestProtocol) -> URL? {
    let baseURL = environment.baseURLString()
    let url = baseURL + request.path
    return URL(string: url)
  }
  
  fileprivate func buildRequestGet(uri: String?, from request: RequestProtocol, baseParams: ServiceParameters? = nil) throws -> URLRequest {
    
    // Get URL
    let url: URL

    if let uriStr = uri, let validURL = URL(string: uriStr) {
     url = validURL
    } else if let validURL = setupURL(request: request) {
     url = validURL
    } else {
      throw NetworkError.errorForMissingURL()
    }
    
    //Get request
    var urlRequest = URLRequest(url: url)
    
    urlRequest.httpMethod = request.method.rawValue
    
    var urlParameters: ServiceParameters? = nil
    var bodyParameters: ServiceParameters? = nil
    
    // If is get method, add base params to url parameters
    urlParameters = request.getUrlParameters(baseParameters: baseParams)
    bodyParameters = request.getBodyParameters(baseParameters: nil)
  
    //Add parameters
    do {
      try self.configureParameters(bodyParameters: bodyParameters,
                                   bodyEncoding: .urlEncoding,
                                   urlParameters: urlParameters,
                                   request: &urlRequest)
      urlRequest.allHTTPHeaderFields = request.headers
      deleteCookies()
      return urlRequest
    } catch {
      throw error
      
    }
  }
  
  fileprivate func buildRequestPost(uri: String?, from request: RequestProtocol, baseParams: ServiceParameters? = nil) throws -> URLRequest {
    
    // Get URL
    let url: URL
    
    if let uriStr = uri, let validURL = URL(string: uriStr) {
      url = validURL
    } else if let validURL = setupURL(request: request) {
      url = validURL
    } else {
      throw NetworkError.errorForMissingURL()
    }
    //Get request
    var urlRequest = URLRequest(url: url)
    
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = request.headers
    deleteCookies()
    
    var urlParameters: ServiceParameters? = nil
    var bodyParameters: ServiceParameters? = nil
    
    // If is get method, add base params to url parameters
    urlParameters = request.getUrlParameters(baseParameters: baseParams)
    bodyParameters = request.getBodyParameters(baseParameters: baseParams)
    
    //Add parameters
    do {
      try self.configureParameters(bodyParameters: bodyParameters,
                                   bodyEncoding: .urlAndJsonEncoding,
                                   urlParameters: urlParameters,
                                   request: &urlRequest)
      return urlRequest
    } catch {
      throw error
    }
  }
  
  fileprivate func buildCustomRequestPost(uri: String?, from request: RequestProtocol, baseParams: ServiceParameters? = nil) throws -> URLRequest {
    // Get URL
    let url: URL
    if let uriStr = uri, let validURL = URL(string: uriStr) {
      url = validURL
    } else if let validURL = setupURL(request: request) {
      url = validURL
    } else {
      throw NetworkError.errorForMissingURL()
    }
    //Get request
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    
    var urlParameters: ServiceParameters? = nil
    var bodyParameters: ServiceParameters? = nil
    
    // If is get method, add base params to url parameters
    urlParameters = request.getUrlParameters(baseParameters: baseParams)
    bodyParameters = request.getBodyParameters(baseParameters: baseParams)
    
    //Add parameters
    do {
      try self.configureParameters(bodyParameters: nil,
                                   bodyEncoding: .urlEncoding,
                                   urlParameters: urlParameters,
                                   request: &urlRequest)
      urlRequest.allHTTPHeaderFields = request.headers
      deleteCookies()
      if let postParams = bodyParameters {
        urlRequest.httpBody = buildMultipartBodyData(withParams: postParams)
      }
      return urlRequest
    } catch {
      throw error
    }
  }
  
  fileprivate func buildMultipartBodyData(withParams params: ServiceParameters) -> Data? {
    var body = Data()
    
    for (key, value) in params {
      // Each parameter must begin with -- and the specified boundary. Start boundary mark
      guard let boundary = "--Boundary-ClaroVideo/iTunes\r\n".data(using: .utf8) else { break }
      body.append(boundary)
      // Add param key
      guard let contentDisposition = "Content-Disposition:form-data; name=\(key)\r\n\r\n".data(using: .utf8) else { break }
      body.append(contentDisposition)
      // Add param value
      guard let stringValue = value as? String else { break }
      guard let param = "\(stringValue)\r\n".data(using: .utf8) else { break }
      body.append(param)
    }
    // End boundary mark
    guard let endBoundary = "--Boundary-ClaroVideo/iTunes--\r\n".data(using: .utf8) else { return nil }
    body.append(endBoundary)
    return body
    
  }
  
  fileprivate func configureParameters(bodyParameters: ServiceParameters?,
                                       bodyEncoding: ParameterEncoding,
                                       urlParameters: ServiceParameters?,
                                       request: inout URLRequest) throws {
    do {
      try bodyEncoding.encode(urlRequest: &request,
                              bodyParameters: bodyParameters, urlParameters: urlParameters)
    } catch {
      throw error
    }
  }
  
  fileprivate func validateTask(request: RequestProtocol?, completion:@escaping (Result<Response,NetworkError>) -> Void) -> ((Data?, URLResponse?, Error?) -> Void) {
    
    return { (data,response,error) in
      // Validation of task error
      if let sesionError = error {
        completion(.failure(NetworkError.errorForParseFailed(error: sesionError.localizedDescription)))
        return
      }
      // Validation of internal error
      let sesionResponse = Response(data: data, request: request)
      if let jsonResponse = sesionResponse.jsonData,
        let httpResponse = response as? HTTPURLResponse,
        let errors = jsonResponse["errors"] {
        DispatchQueue.main.async {
          completion(.failure(NetworkError.mapError(errorResponse: errors, httpCode: httpResponse.statusCode, jsonResponse: jsonResponse)))
        }
        return
      }
      //Send Success
      DispatchQueue.main.async {
        completion(.success(sesionResponse))
      }
    }
  }
  
  fileprivate func deleteCookies() {
    let cookieStore = HTTPCookieStorage.shared
    cookieStore.cookies?.forEach({ (cookie) in
      cookieStore.deleteCookie(cookie)
    })
  }
}
