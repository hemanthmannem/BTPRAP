CLASS zhem_cl_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
    INTERFACES if_oo_adt_classrun .

CLASS-METHODS get_product_mrp IMPORTING
                                    VALUE(i_tax) type i
                                  EXPORTING
                                    VALUE(otab) type zhem_tt_product_mrp.
                                    CLASS-METHODS GET_TOtaL_SALES for table FUNCTION zhem_tbf_sales.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zhem_cl_amdp IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
 zhem_cl_amdp=>get_product_mrp(
       EXPORTING
         i_tax = 18
       IMPORTING
         otab  = data(itab)
     ).

     out->write(
      EXPORTING
        data   = itab
    ).
  ENDMETHOD.

  METHOD get_product_mrp by database PROCEDURE FOR HDB
  LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zhem_tbl_product.


*   now declare variables
    declare lv_Count integer;
    declare i integer;
    declare lv_mrp bigint;
    declare lv_price_d integer;

*   get all the products in a implicit table (like a internal table in abap)
    lt_prod = select * from zhem_tbl_product;

*   get the record count of the table records
    lv_count := record_count( :lt_prod );

*   loop at each record one by one and calculate the price after discount (dbtable)
    for i in 1..:lv_count do
*   calculate the MRP based on input tax
        lv_price_d := :lt_prod.price[i] * ( 100 - :lt_prod.discount[i] ) / 100;
        lv_mrp := :lv_price_d * ( 100 + :i_tax ) / 100;
*   if the MRP is more than 15k, an additional 10% discount to be applied
        if lv_mrp > 15000 then
            lv_mrp := :lv_mrp * 0.90;
        END IF ;
*   fill the otab for result (like in abap we fill another internal table with data)
        :otab.insert( (
                          :lt_prod.name[i],
                          :lt_prod.category[i],
                          :lt_prod.price[i],
                          :lt_prod.currency[i],
                          :lt_prod.discount[i],
                          :lv_price_d,
                          :lv_mrp
                      ), i );
    END FOR ;
  ENDMETHOD.
  method get_total_sales by DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY using zhem_tbl_bpa zhem_tbl_so_hdr zhem_tbl_so_item.
  return SELECT  bpa.client,
            bpa.company_name,
            sum( item.amount ) as total_sales,
            item.currency as currency_code,
           RANK ( ) OVER ( order by sum( item.amount ) desc ) as customer_rank
  from zhem_tbl_bpa as bpa
  INNER JOIN zhem_tbl_so_hdr as sls
  on bpa.bp_id = sls.buyer
  inner join zhem_tbl_so_item as item
    on sls.order_id = item.order_id
    group by bpa.client,
            bpa.company_name,
            item.currency ;
  ENDMETHOD.


ENDCLASS.
