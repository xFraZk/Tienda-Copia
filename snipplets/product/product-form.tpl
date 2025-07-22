<div class="js-sticky-product">
    <div class="product-detail-container{% if settings.positive_color_background %} container-invert{% endif %}">
        {# Product name and breadcrumbs #}

        {% embed "snipplets/page-header.tpl" %}
            {% block page_header_text %}{{ product.name }}{% endblock page_header_text %}
        {% endembed %}

        {# Product price #}

        <div class="mt-2 mb-4" data-store="product-price-{{ product.id }}">
            <span class="price-container">
                <span class="d-inline-block">
                    <span class="js-price-display {% if product_can_show_installments or (product.promotional_offer and not product.promotional_offer.script.is_percentage_off) %}mb-2{% endif %}" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">{% if product.display_price %}{{ product.price | money }}{% endif %}</span>
                </span>
                <span class="d-inline-block">
                   <span id="compare_price_display" class="js-compare-price-display price-compare {% if product_can_show_installments or (product.promotional_offer and not product.promotional_offer.script.is_percentage_off) %}mb-2{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</span>
                </span>
            </span>
            {{ component('price-without-taxes', {
                    container_classes: "mt-1 mb-2 font-small opacity-60",
                })
            }}
            {{ component('payment-discount-price', {
                    visibility_condition: settings.payment_discount_price,
                    location: 'product',
                    container_classes: "font-medium text-accent mt-1",
                })
            }}
        </div>

        {{ component('promotions-details', {
            promotions_details_classes: {
                container: 'js-product-promo-container mb-4',
                promotion_title: 'h4 mb-2 text-accent h-font-body',
                valid_scopes: 'mb-0',
                categories_combinable: 'mb-0',
                not_combinable: 'font-small mb-0',
                progressive_discounts_table: 'table mb-2 mt-3',
                progressive_discounts_hidden_table: 'table mb-2',
                progressive_discounts_show_more_link: 'btn-link btn-link-primary mb-4',
                progressive_discounts_promotion_quantity: 'font-weight-light text-lowercase'
            },
            svg_sprites: false,
            custom_control_show: include("snipplets/svg/chevron-down.tpl", { svg_custom_class: "icon-inline icon-w-14 icon-md ml-2" }),
            custom_control_hide: include("snipplets/svg/chevron-up.tpl", { svg_custom_class: "icon-inline icon-w-14 icon-md ml-2" }),
        }) }}

        {# Product installments #}

        {% include "snipplets/payments/installments.tpl" with {'product_detail' : true} %}

        {# Product availability #}

        {% set has_product_available = product.available and product.display_price %}

        {# Free shipping minimum message #}

        {% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
        {% set has_product_free_shipping = product.free_shipping %}

        {% if not product.is_non_shippable and has_product_available and (has_free_shipping or has_product_free_shipping) %}
            <div class="free-shipping-message pb-2 mb-4">
                <strong class="text-accent">{{ "Envío gratis" | translate }}</strong>
                <span {% if has_product_free_shipping %}style="display: none;"{% else %}class="js-shipping-minimum-label"{% endif %}>
                    {{ "superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
                </span>
                {% if not has_product_free_shipping %}
                    <div class="js-free-shipping-discount-not-combinable font-small mt-1">
                        {{ "No acumulable con otras promociones" | translate }}
                    </div>
                {% endif %}
            </div>
        {% endif %}

        {# Product form, includes: Variants, CTA and Shipping calculator #}

        <div class="js-fixed-product-form-placeholder" style="display: none;">
        </div>
        <form id="product_form" class="js-product-form js-fixed-product-form" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
            <input type="hidden" name="add_to_cart" value="{{product.id}}" />

            {# Fixed add to cart on scroll #}

            <div class="js-product-form-toggle row">
                <div class="col mb-3 d-md-none" data-store="product-price-{{ product.id }}">
                    <div class="price-container">
                        <span class="d-inline-block">
                            <span class="js-price-display" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %}>{% if product.display_price %}{{ product.price | money }}{% endif %}</span>
                        </span>
                        <span class="d-inline-block">
                           <span id="compare_price_display" class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</span>
                        </span>
                    </div>
                    {{ component('payment-discount-price', {
                            visibility_condition: settings.payment_discount_price,
                            location: 'product',
                            container_classes: "font-medium text-accent mt-1",
                        })
                    }}
                </div>
                {% if product.variations %}
                    <div class="col-auto d-md-none">
                        {% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "js-product-form-toggle-icon icon-inline icon-lg"} %}
                        <span class="js-product-form-toggle-icon" style="display: none;">
                          {% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: "icon-inline icon-lg"} %}
                        </span>
                    </div>
                {% endif %}
            </div>

            <div class="{% if product.variations %}js-product-variants{% else %}js-product-without-variants{% endif %} form-row">
                {% if product.variations %}
                    {% include "snipplets/product/product-variants.tpl" %}
                {% endif %}

                {% if product.available and product.display_price %}
                    {% include "snipplets/product/product-quantity.tpl" %}
                {% endif %}

                {% if settings.last_product %}
                    <div class="{% if product.variations %}js-last-product {% endif %}col-12 text-center text-md-left"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
                        <div class="h6 h-font-body text-accent font-weight-bold mb-4">
                            {{ settings.last_product_text }}
                        </div>
                    </div>
                {% endif %}
            </div>

            {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
            {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

            {# Add to cart CTA #}

            <div class="mb-4">

                <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-block mb-3 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button"/>

                {# Fake add to cart CTA visible during add to cart event #}

                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-block mb-3"} %}

                <div class="js-added-to-cart-product-message mb-3" style="display: none;">
                    {{'Ya agregaste este producto.' | translate }}<a href="#" class="js-modal-open js-fullscreen-modal-open btn btn-link ml-2 pl-0 py-0" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                </div>

                {# Free shipping visibility message #}

                {% set free_shipping_minimum_label_changes_visibility = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

                {% set include_product_free_shipping_min_wording = cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

                {% if not product.is_non_shippable and has_product_available and has_free_shipping and not has_product_free_shipping %}

                    {# Free shipping add to cart message #}

                    {% if include_product_free_shipping_min_wording %}

                        {% include "snipplets/shipping/shipping-free-rest.tpl" with {'product_detail': true} %}

                    {% endif %}

                    {# Free shipping achieved message #}

                    <div class="{% if free_shipping_minimum_label_changes_visibility %}js-free-shipping-message{% endif %} text-accent font-weight-bold mb-3 w-100" {% if not cart.free_shipping.cart_has_free_shipping %}style="display: none;"{% endif %}>
                        {{ "¡Genial! Tenés envío gratis" | translate }}
                    </div>
                {% endif %}
            </div>
        </form>

        {# Product description #}

        {% if product.description is not empty %}
            <div class="js-product-description product-description user-content mb-4" data-store="product-description-{{ product.id }}">
                {{ product.description }}
                <div class="js-view-description product-description-more" style="display: none;">
                    <div class="btn-link mt-4">
                        {% if settings.positive_color_background %}
                            {% set view_description_icon_class = 'icon-inline icon-lg svg-icon-invert ml-1' %}
                         {% else %}
                            {% set view_description_icon_class = 'icon-inline icon-lg svg-icon-text ml-1' %}
                        {% endif %}
                        <span class="js-view-more">
                            {{ "Ver más" | translate }}
                            {% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: view_description_icon_class} %}
                        </span>
                        <span class="js-view-less" style="display: none;">
                            {{ "Ver menos" | translate }}
                            {% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: view_description_icon_class} %}
                        </span>
                    </div>
                </div>
            </div>
        {% endif %}
    </div>

    <div class="js-product-detail-bottom product-detail-bottom">
        {# Define contitions to show shipping calculator and store branches on product page #}

        {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

        {% if show_product_fulfillment %}

            {# Shipping calculator and branch link #}

            <div id="product-shipping-container" class="product-shipping-calculator container-invert list mb-5" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

                {# Shipping Calculator #}

                {% if store.has_shipping %}
                    {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
                {% endif %}

                {% if store.branches %}

                    {# Link for branches #}
                    {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
                {% endif %}
            </div>
        {% endif %}

        {# Product share #}

        {% include 'snipplets/social/social-share.tpl' %}
    </div>

    {# Product payments details #}

    {% include 'snipplets/product/product-payment-details.tpl' %}

</div>
