@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sales item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zhem_cds_sales as select from zhem_tbl_so_hdr as hdr
association[1..*] to zhem_tbl_so_item as _Items on
$projection.OrderId = _Items.order_id
{
    key hdr.order_id as OrderId,
    hdr.order_no as OrderNo,
    hdr.buyer as Buyer,
     @Semantics.amount.currencyCode: 'CurrencyCode'
    hdr.gross_amount as GrossAmount,
    hdr.currency_code as CurrencyCode,
    hdr.created_by as CreatedBy,
    hdr.created_on as CreatedOn,
    _Items
    
}
