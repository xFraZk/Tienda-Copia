{% if settings.quick_shop %}
    {% embed "snipplets/modal.tpl" with{modal_id: 'quickshop-modal', modal_class: 'quickshop', modal_position: 'bottom modal-bottom-sheet', modal_transition: 'slide', modal_header: true, modal_width: 'centered modal-docked-md modal-docked-md-centered w-100', modal_body_class: 'mt-0', modal_mobile_full_screen: 'true', modal_bottom_sheet: true, modal_quickshop: true } %}
        {% block modal_body %}
        <div class="js-item-product" data-product-id="">
            <div class="js-product-container js-quickshop-container js-quickshop-modal js-quickshop-modal-shell" data-variants="" data-quickshop-id="">
                <div class="js-item-variants">                    
                    <div class="container-fluid p-0">
                        <div class="row align-items-center">
                            <div class="col-1 d-none d-md-block pr-0">
                                <div class="quickshop-img-container">
                                    <img srcset="" class="js-item-image js-quickshop-img quickshop-img"/>
                                </div>
                            </div>
                            <div class="col-12 col-md-auto mb-2 pr-5 pr-md-3">
                                <div class="js-item-name h2 h4-md h-font-body mb-1 mb-md-2" data-store="product-item-name-{{ product.id }}"></div>
                                <div class="mb-3 mb-md-0" data-store="product-item-price-{{ product.id }}">
                                    <span class="h4 h-font-body d-inline-block"><span class="js-compare-price-display font-weight-bold price-compare ml-0"></span></span>
                                    <span class="h4 h-font-body d-inline-block"><span class="js-price-display font-weight-bold text-primary"></span></span>
                                    {{ component('payment-discount-price', {
                                            visibility_condition: settings.payment_discount_price,
                                            location: 'product',
                                            container_classes: "text-accent mt-1",
                                            text_classes: {
                                                price: 'font-weight-bold',
                                            },
                                        }) 
                                    }}
                                </div>
                            </div>
                            <div class="col-12 col-md">
                                <div id="quickshop-form"></div>
                            </div>
                        </div>
                    </div>                    
                </div>
            </div>
        </div>
        {% endblock %}
    {% endembed %}
{% endif %}