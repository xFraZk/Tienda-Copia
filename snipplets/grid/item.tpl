{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}
{% set columns = settings.grid_columns %}


{# Item image slider #}

{% set show_image_slider = 
    (template == 'category' or template == 'search')
    and settings.product_item_slider 
    and not reduced_item
    and not slide_item
    and not has_filters
    and product.other_images
%}

{% if show_image_slider %}
    {% set slider_controls_container_class = 'item-slider-controls-container svg-icon-secondary d-none d-md-block' %}
    {% set slider_control_position = settings.quick_shop ? ' item-slider-pagination-centered' %}
    {% set more_images_message_position = settings.quick_shop ? ' item-more-images-message-centered' %}
    {% set slider_control_class = 'icon-inline icon-2x' %}
    {% set control_prev = include ('snipplets/svg/chevron-left.tpl', {svg_custom_class: slider_control_class}) %}
    {% set control_next = include ('snipplets/svg/chevron-right.tpl', {svg_custom_class: slider_control_class}) %}
{% endif %}

{# Secondary images #}

{% set show_secondary_image = settings.product_hover %}

<div class="js-item-product {% if slide_item %}js-item-slide swiper-slide{% else %}col-12 col-md{% if columns == 1 %}-6{% elseif columns == 2 %}-4{% else %}-3{% endif %}{% endif %} item item-product {% if full_item %}item-full{% endif %} {% if not product.display_price %} no-price{% endif %} {% if reduced_item %}item-product-reduced mb-1{% endif %}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}">
    <div class="item-product-card">
        {% if (settings.quick_shop or settings.product_color_variants) and not (full_item or reduced_item) %}
            <div class="js-product-container js-quickshop-container {% if product.variations %}js-quickshop-has-variants{% else %}js-quickshop-direct{% endif %}" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}{% if slide_item and section_name %}-{{ section_name }}{% endif %}">
        {% endif %}

            {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

            {% set image_classes = 'js-item-image lazyautosizes lazyload img-absolute img-absolute-centered fade-in' %}
            {% set data_expand = show_image_slider ? '50' : '-10' %}

            {% set floating_elements %}
                {% if not (full_item or reduced_item) %}

                    {% include 'snipplets/labels.tpl' %}

                    {% if settings.quick_shop and product.available and product.display_price %}

                        {# Trigger quickshop actions #}
                        
                        <div class="item-actions">
                            {% if product.variations %}

                                {# Open quickshop popup if has variants #}
                                <div class="item-submit-container btn btn-primary">
                                    <a data-toggle="#quickshop-modal" data-modal-url="modal-fullscreen-quickshop" class="js-quickshop-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open js-fullscreen-modal-open btn btn-primary item-btn-quickshop" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" >{% include "snipplets/svg/shopping-bag.tpl" with {svg_custom_class: 'js-quickshop-bag'} %}</a>
                                </div>
                            {% else %}

                                {# If not variants add directly to cart #}
                                <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                                    <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                                    {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                                    {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                                    <input type="number" name="quantity" value="1" class="js-quantity-input hidden" aria-label="{{ 'Cambiar cantidad' | translate }}" >

                                    <div class="js-quickshop-add-container item-submit-container btn btn-primary">
                                        <input type="submit" class="js-addtocart js-prod-submit-form js-quickshop-icon-add btn btn-primary item-btn-quickshop {{ state }}" value="" alt="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />
                                        {% include "snipplets/svg/shopping-bag.tpl" with {svg_custom_class: 'js-quickshop-bag'} %}
                                    </div>

                                    {# Fake add to cart CTA visible during add to cart event #}

                                    {% include 'snipplets/placeholders/button-placeholder.tpl' with {item: true, custom_class: "item-submit-container item-btn-quickshop"} %}

                                </form>
                            {% endif %}
                        </div>
                    {% endif %}
                {% endif %}
            {% endset %}

            {% if full_item %}
                <div class="row no-gutters">
            {% endif %}
            {{ component(
                'product-item-image', {
                    image_lazy: true,
                    image_lazy_js: true,
                    image_thumbs: ['small', 'medium', 'large', 'huge', 'original'],
                    image_data_expand: data_expand,
                    image_secondary_data_sizes: 'auto',
                    secondary_image: show_secondary_image,
                    slider: show_image_slider,
                    placeholder: true,
                    svg_sprites: false,
                    custom_content: floating_elements,
                    product_item_image_classes: {
                        image_container: 'item-image' ~ (full_item ? ' col-4 col-md-3'),
                        image_padding_container: 'position-relative d-block',
                        image_link: show_image_slider or show_secondary_image ? 'item-image-link',
                        image: image_classes,
                        image_featured: 'item-image-featured',
                        image_secondary: 'item-image-secondary',
                        slider_container: 'swiper-container position-absolute h-100 w-100',
                        slider_wrapper: 'swiper-wrapper',
                        slider_slide: 'swiper-slide item-image-slide',
                        slider_control_pagination: 'item-slider-pagination d-md-none' ~ slider_control_position,
                        slider_control_prev_container: 'swiper-button-prev ' ~ slider_controls_container_class,
                        slider_control_next_container: 'swiper-button-next ' ~ slider_controls_container_class,
                        more_images_message: 'item-more-images-message' ~ more_images_message_position,
                        placeholder: 'placeholder-fade',
                    },
                    custom_control_prev: control_prev,
                    custom_control_next: control_next,
                })
            }}
            {% if ((settings.quick_shop or settings.product_color_variants) and not (full_item or reduced_item)) and product.variations %}

                {# Hidden product form to update item image and variants: Also this is used for quickshop popup #}
                
                <div class="js-item-variants hidden">
                    <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />

                        <div class="container-fluid p-0">
                            <div class="js-product-variants js-product-quickshop-variants form-row align-items-center">
                                    
                                {# Set columns for variant on desktop #}

                                {% if product.variations | length == 2 %}
                                    {% set variants_mobile_container_cols = '-12' %}
                                    {% set variants_desktop_container_cols = '-5' %}
                                    {% set qty_mobile_container_cols = '-12' %}
                                    {% set qty_desktop_container_cols = '-3' %}
                                {% elseif product.variations | length == 1 %}
                                    {% set variants_mobile_container_cols = '-6' %}
                                    {% set variants_desktop_container_cols = '-3' %}
                                    {% set qty_mobile_container_cols = '-6' %}
                                    {% set qty_desktop_container_cols = '-5' %}
                                {% endif %}

                                    {% if product.variations | length < 3 %}
                                            <div class="col{{ variants_mobile_container_cols }} col-md{{ variants_desktop_container_cols }}">
                                                <div class="form-row">
                                    {% endif %}
                                                {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                                    {% if product.variations | length < 3 %}
                                                </div>
                                            </div>
                                    {% endif %}
                                {% if product.available and product.display_price and settings.quick_shop %}
                                    {% if product.variations | length < 3 %}
                                    <div class="col{{ qty_mobile_container_cols }} col-md{{ qty_desktop_container_cols }}">
                                        <div class="form-row justify-content-end">
                                    {% endif %}
                                        {% include "snipplets/product/product-quantity.tpl" with {quickshop: true} %}
                                    {% if product.variations | length < 3 %}
                                        </div>
                                    </div>
                                    {% endif %}
                                {% endif %}
                                {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                                {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                                <div class="col-12 col-md-4 mt-{% if product.variations | length == 3 %}2{% else %}4{% endif %} mt-md-1">

                                    {# Add to cart CTA #}

                                    <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary mb-1 btn-block {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                                    {# Fake add to cart CTA visible during add to cart event #}

                                    {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-block mb-1"} %}
                                </div>

                                <a href="{{ product_url_with_selected_variant }}" class="btn btn-link btn-block d-md-none mt-3 pt-0">{{ 'Ver más detalles' | translate }}</a>
                            </div>
                        </div>
                    </form>
                </div>

            {% endif %}
            <div class="{% if full_item %}col-8 col-md-9 px-3 {% endif %}item-description {% if reduced_item %}p-2 m-1{% endif %}" data-store="product-item-info-{{ product.id }}">
                {% if settings.product_color_variants and product.variations and not (full_item or reduced_item) %}
                    <div class="mb-3">
                        {% include 'snipplets/grid/item-colors.tpl' %}
                    </div>
                {% endif %}
                <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" class="item-link">
                    <div class="js-item-name item-name {% if reduced_item %}font-small mb-1{% else %}mb-3{% endif %}" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>
                    {% if product.display_price %}
                        <div class="item-price-container mb-{% if reduced_item %}0{% elseif full_item%}2{% else %}3{% endif %}" data-store="product-item-price-{{ product.id }}">
                            <span class="js-price-display item-price" data-product-price="{{ product.price }}">
                                {{ product.price | money }}
                            </span>
                            {% if not reduced_item %}
                                <span class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %}style="display:inline-block;"{% endif %}>
                                    {{ product.compare_at_price | money }}
                                </span>
                            {% endif %}
                            {{ component('payment-discount-price', {
                                    visibility_condition: settings.payment_discount_price and not reduced_item,
                                    location: 'product',
                                    container_classes: "mt-1 font-small",
                                }) 
                            }}
                        </div>
                    {% endif %}
                    {% if not reduced_item %}
                        {% include 'snipplets/payments/installments.tpl' %}
                    {% endif %}
                    {% if full_item %}
                        {% include 'snipplets/labels.tpl' with {full_item: true}%}
                    {% endif %}
                </a>
            </div>
            {% if full_item %}
                </div>
            {% endif %}
            
            {# Structured data to provide information for Google about the product content #}
            {{ component('structured-data', {'item': true}) }}
        {% if (settings.quick_shop or settings.product_color_variants) and not (full_item or reduced_item) %}
            </div>
        {% endif %}
    </div>
</div>