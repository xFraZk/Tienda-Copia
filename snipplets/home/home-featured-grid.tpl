{# /*============================================================================
  #Home featured grid
==============================================================================*/

#Properties

#Featured Slider

#}

{% set featured_slider = featured_slider | default(false) %}
{% set sale_slider = sale_slider | default(false) %}
{% set category_slider = category_slider | default(false) %}

{% set category_products_url = settings.category_products_url %}

<div class="container-fluid" {% if featured_slider or sale_slider %}data-store="products-home-{% if featured_slider %}featured{% elseif sale_slider %}sale{% else %}category{% endif %}"{% endif %}>
    <div class="row{% if featured_slider %} align-items-center justify-content-between{% endif %}">
        
        {% if featured_slider and (settings.featured_products_title or settings.featured_products_description) %}
            <div class="col-md-4{% if settings.positive_color_background %} container-invert{% endif %}">
                <h3 class="h1 mb-2">{{ settings.featured_products_title }}</h3>
                {% if settings.featured_products_description %}
                    <p>{{ settings.featured_products_description }}</p>
                {% endif %}
                <a href="{{ store.products_url }}" class="btn btn-primary d-md-inline-block d-none mt-3">{{ "Ver todos los productos" | translate }}</a>
            </div>
        {% endif %}
        {% if category_slider %}
            <div class="col-12 pr-md-3 pr-0 pb-5">
                {% for category in categories %}
                    {% if category.url == category_products_url %}
                        {% include 'snipplets/home/home-featured-category.tpl' with { 'categories' : category.subcategories } %}
                    {% endif %}
                    {% for subcategory in category.subcategories %}
                        {% if subcategory.url == category_products_url %}
                            {% include 'snipplets/home/home-featured-category.tpl' with { 'categories' : subcategory.subcategories, 'category' : subcategory } %}
                        {% endif %}
                        {% for subsubcategory in subcategory.subcategories %}
                            {% if subsubcategory.url == category_products_url %}
                                {% include 'snipplets/home/home-featured-category.tpl' with { 'categories' : subsubcategory.subcategories, 'category' : subsubcategory } %}
                            {% endif %}
                        {% endfor %}
                    {% endfor %}
                {% endfor %}
            </div>
        {% endif %}

        {% if featured_slider or sale_slider %}
            <div class="{% if featured_slider %}col-md-6 pt-3 pt-md-5{% else %}col-12 pr-md-3 pr-0{% endif %}">
                {% if sale_slider and settings.sale_products_title %}
                    <h3 class="h1{% if settings.positive_color_background %} text-secondary{% endif %}">{{ settings.sale_products_title }}</h3>
                {% endif %}
                <div class="js-swiper-{% if featured_slider %}featured{% else %}sale{% endif %} swiper-container p-1">
                    <div class="swiper-wrapper">
        {% endif %}

        {% if featured_slider %}
            {% set sections_products = sections.primary.products %}
            {% set section_name = 'primary' %}
        {% endif %}
        {% if sale_slider %}
            {% set sections_products = sections.sale.products %}
            {% set section_name = 'sale' %}
        {% endif %}

        {% if featured_slider or sale_slider %}
            {% for product in sections_products %}
                {% if featured_slider %}
                    {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'full_item': true, 'section_name': section_name} %}
                {% elseif sale_slider %}
                    {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name} %}
                {% else %}
                    {% include 'snipplets/grid/item.tpl' %}
                {% endif %}
            {% endfor %}
        {% endif %}

        {% if featured_slider or sale_slider %}
                    </div>
                </div>
                {% if featured_slider %}
                    <div class="d-inline-block d-md-none">
                        <div class="js-swiper-featured-pagination swiper-pagination swiper-pagination-bullets position-relative pl-0"></div>
                    </div>
                    <a href="{{ store.products_url }}" class="btn btn-primary d-block d-md-none mt-3">{{ "Ver todos los productos" | translate }}</a>
                {% endif %}
                <div class="js-swiper-{% if featured_slider %}featured{% else %}sale{% endif %}-prev swiper-button-prev d-none d-md-block {% if settings.positive_color_background %}svg-icon-invert{% else %}svg-icon-text{% endif %}">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline icon-2x mr-1"} %}</div>
                <div class="js-swiper-{% if featured_slider %}featured{% else %}sale{% endif %}-next swiper-button-next d-none d-md-block {% if settings.positive_color_background %}svg-icon-invert{% else %}svg-icon-text{% endif %}">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline icon-2x ml-1"} %}</div>
            </div>
        {% endif %}

        {% if show_help %}
            {% for i in 1..4 %}
                {% if loop.index % 4 == 1 %}
                    <div class="grid-row">
                {% endif %}

                <div class="span3">
                    <div class="item">
                        <div class="item-image-container">
                            <a href="/admin/products/new" target="_top">{{'placeholder-product.png' | static_url | img_tag}}</a>
                        </div>
                        <div class="item-info-container">
                            <div class="title"><a href="/admin/products/new" target="_top">{{"Producto" | translate}}</a></div>
                            <div class="price">{{"$0.00" | translate}}</div>
                        </div>
                    </div>
                </div>

                {% if loop.index % 4 == 0 or loop.last %}
                    </div>
                {% endif %}
            {% endfor %}
        {% endif %}
    </div>
</div>
