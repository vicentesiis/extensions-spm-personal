//
//  CVListOption.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 11/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public final class CVListOption: NSObject {
  /**
   *  @brief El identificador único del objeto en la tabla.
   */
  public var optionID:String = ""

  /**
   *  @brief El texto a desplegar en la celda de la tabla.s
   */
  public var optionText:String = ""

  /**
   *  @brief @b YES Para indicar que la opción está marcada como `seleccionada`,
   *         @b NO en caso contrario.
   */
  public var selected:Bool = false
}
