@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sales composite view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Analytics.dataCategory: #CUBE
define view entity zhem_i_cds_salescube as select from zhem_cds_sales
association[1] to ZHEM_CDS_bpa as _BusinessPartner on
$projection.Buyer = _BusinessPartner.BpId
association[1] to zhem_cds_product as _product on
$projection.product = _product.ProductId

{
    key zhem_cds_sales.OrderId,
    key zhem_cds_sales._Items.item_id as ItemId,
    zhem_cds_sales.OrderNo,
    zhem_cds_sales.Buyer,
    zhem_cds_sales.CreatedBy,
    zhem_cds_sales.CreatedOn,
    /* Associations*/
    
   
    zhem_cds_sales._Items.product as product,
    @DefaultAggregation: #SUM
    @Semantics.amount.currencyCode: 'CurrencyCode'
    zhem_cds_sales._Items.amount as GrossAmount,
    zhem_cds_sales._Items.currency as CurrencyCode,
    @DefaultAggregation: #SUM
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    zhem_cds_sales._Items.qty as quan,
    zhem_cds_sales._Items.uom as UnitOfMeasure,
    _BusinessPartner,
    _product
    
    
}
