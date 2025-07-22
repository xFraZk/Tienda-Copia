<div id="single-product" class="section-products-related p-0 m-0">
    <div class="container-fluid p-0">
        <div class="section-single-product row no-gutters">
            <div class="col-md-7">
                <div class="js-swiper-product-demo product-detail-slider swiper-container">
                    <div class="labels labels-top">
                        <div class="label label-accent">{{ "35% OFF" | translate }}</div>
                    </div>
                    <div class="swiper-wrapper">
                         <div class="js-product-slide swiper-slide slider-slide product-slide" data-image="0" data-image-position="0">
                            {{ component('placeholders/product-placeholder',{
                                    type: 'dress',
                                })
                            }}
                         </div>
                         <div class="js-product-slide swiper-slide slider-slide product-slide" data-image="1" data-image-position="1">
                            {{ component('placeholders/product-placeholder',{
                                    type: 'dress',
                                    color: 'red',
                                })
                            }}
                         </div>
                         <div class="js-product-slide swiper-slide slider-slide product-slide" data-image="2" data-image-position="2">
                            {{ component('placeholders/product-placeholder',{
                                    type: 'dress',
                                    color: 'green',
                                })
                            }}
                         </div>
                    </div>
                    <div class="js-swiper-product-demo-pagination swiper-pagination swiper-pagination-white h5 font-weight-normal d-block d-md-none"></div>
                </div>
                {% snipplet 'placeholders/product-detail-image-placeholder.tpl' %}
            </div>
            <div class="col-md-5">
                <div class="product-detail-container m-0">
                    {# Product name and breadcrumbs #}
                    <section class="page-header m-0">
                        <div class="breadcrumbs">
                            <a class="crumb" href="{{ store.url }}" title="{{ store.name }}">{{ "Inicio" | translate }}</a>
                            <span class="divider mr-1">></span>
                            <a class="crumb" href="{{ store.products_url }}" title="{{ "Productos" | translate }}">{{ "Productos" | translate }}</a>
                            <span class="divider mr-1">></span>
                            <span class="crumb active">{{ "Producto de ejemplo" | translate }}</span>
                        </div>
                        <h1>{{ "Producto de ejemplo" | translate }}</h1>
                    </section>

                    {# Product price #}

                    <div class="price-container mb-4">
                        <span class="d-inline-block">
                            <span class="text-primary">
                                {% if store.country == 'BR' %}
                                    {{"18200" | money }}
                                {% else %}
                                    {{"182000" | money }}
                                {% endif %}
                            </span>
                        </span>
                        <span class="d-inline-block">
                           <span class="price-compare font-weight-normal" style="display:block;">
                                {% if store.country == 'BR' %}
                                    {{"28000" | money }}
                                {% else %}
                                    {{"280000" | money }}
                                {% endif %}
                           </span>
                        </span>
                    </div>

                    {# Product installments #}

                    <div class="row mb-4">
                        <span class="col">
                            <span class="float-left mr-2">
                                {% include "snipplets/svg/credit-card-blank.tpl" with {svg_icon_underline: true, svg_custom_class : "icon-inline svg-icon-text icon-lg"} %}
                            </span>
                            <span class="d-table text-inline">
                                <span>{{ "Hasta 12 cuotas" | translate }}</span>
                            </span>
                        </span>
                    </div>

                    {# Product form, includes: Variants, CTA and Shipping calculator #}

                    <form id="product_form" class="js-product-form" method="post" action="">
                        <input type="hidden" name="add_to_cart" value="2243561" />

                        <div class="form-row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label class="form-label" for="variation_1">{{ "Color" | translate }}</label>
                                    <select id="variation_1" class="form-select" name="variation[0]">
                                        <option value="{{ "Verde" | translate }}">{{ "Verde" | translate }}</option>
                                        <option value="{{ "Rojo" | translate }}">{{ "Rojo" | translate }}</option>
                                    </select>
                                    <div class="form-select-icon mr-3">
                                        {% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "icon-inline icon-w-14"} %}
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                {% embed "snipplets/forms/form-input.tpl" with{
                                type_number: true, input_value: '1', 
                                input_name: 'quantity' ~ item.id, 
                                input_custom_class: 'js-quantity-input form-control-quantity text-center', 
                                input_label_text: 'Cantidad' | translate,
                                input_append_content: true, 
                                input_group_custom_class: 'js-quantity form-quantity', 
                                form_control_quantity: true,
                                input_min: '1'} %}
                                    {% block input_prepend_content %}
                                        <span class="js-quantity-down form-quantity-icon btn p-0">
                                            {% include "snipplets/svg/minus.tpl" with {svg_custom_class: "icon-inline icon-w-12 icon-lg svg-icon-text"} %}
                                        </span>
                                    {% endblock input_prepend_content %}
                                    {% block input_append_content %}
                                        <span class="js-quantity-up form-quantity-icon form-quantity-icon-up btn p-0">
                                            {% include "snipplets/svg/plus.tpl" with {svg_custom_class: "icon-inline icon-w-12 icon-lg svg-icon-text"} %}
                                        </span>
                                    {% endblock input_append_content %}
                                {% endembed %}
                            </div>
                        </div>
                        <div class="mb-4">
                            <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-block mb-4 cart" value="{{ 'Agregar al carrito' | translate }}" />
                        </div>
                     </form>

                    {# Product description #}
                    <div class="product-description user-content">
                        <p>{{ "¡Este es un producto de ejemplo! Para poder probar el proceso de compra, debes" | translate }}
                            <a href="/admin/products" target="_top">{{ "agregar tus propios productos." | translate }}</a>
                        </p>
                    </div>
                </div>
                <div class="js-product-detail-bottom product-detail-bottom">
                    {# Product share #}
                    {% include 'snipplets/social/social-share.tpl' %}
                </div>
            </div>
            
        </div>
    </div>  
</div>
<section id="related-products" class="section-products-related pl-2 px-md-3">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12 pr-md-3 pr-0">
                <h3 class="h1 text-secondary">{{ "Productos relacionados" | translate }}</h3>
                <div class="js-swiper-related-demo swiper-container p-md-1">
                    <div class="swiper-wrapper">
                        {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_1': true}  %}
                        {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_2': true}  %}
                        {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_4': true}  %}
                        {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_6': true}  %}
                        {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_7': true}  %}
                    </div>
                </div>
                <div class="js-swiper-related-demo-prev swiper-button-prev d-none d-md-block svg-icon-invert">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline icon-2x mr-1"} %}</div>
                <div class="js-swiper-related-demo-next swiper-button-next d-none d-md-block svg-icon-invert">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline icon-2x ml-1"} %}</div>
            </div>
        </div>
    </div>
    <div class="section-products-related-background"></div>
</section>