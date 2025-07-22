{% set label_accent_classes = 'label label-accent ' %}

{{ component(
  'labels', {
    prioritize_promotion_over_offer: true,
    promotion_quantity_long_wording: true,
    promotion_nxm_long_wording: false,
    labels_classes: {
      group: 'js-labels-floating-group ' ~ (product_detail ? 'labels-top ') ~ (product_detail and settings.ad_bar and settings.ad_text ? 'labels-top-more ') ~ (full_item ? 'mt-2'),
      promotion: label_accent_classes,
      promotion_primary_text: 'd-block',
      promotion_secondary_text: 'font-smallest',
      offer: 'js-offer-label ' ~ label_accent_classes,
      shipping: label_accent_classes ~ (not full_item ? 'mt-1'),
      no_stock: 'js-stock-label label label-default',
    },
  })
}}
