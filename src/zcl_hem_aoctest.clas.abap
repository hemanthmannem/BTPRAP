CLASS zcl_hem_aoctest DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hem_aoctest IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  out->write( 'check' ).
  ENDMETHOD.
ENDCLASS.
