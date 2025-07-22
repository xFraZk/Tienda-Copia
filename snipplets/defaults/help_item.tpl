{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}
{% set columns = settings.grid_columns %}

<div class="js-item-product {% if slide_item %}js-item-slide swiper-slide{% else %}{% if not full_item %}col-12 col-md{% if columns == 1 %}-6{% elseif columns == 2 %}-4{% else %}-3{% endif %}{% endif %}{% endif %} item item-product" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}">
    <div class="item-product-card">
        {% if full_item %}
            <div class="row no-gutters">
        {% endif %}
        <div class="item-image{% if full_item %} col-4 col-md-3{% endif %}">
            <div class="p-relative">
                <a href="{{ store.url }}/product/example" title="{{ "Producto de ejemplo" | translate }}">
                    {% set type_value = 
                        help_item_1 ? 'shirt' : 
                        help_item_2 ? 'camera' :
                        help_item_3 ? 'dress' :
                        help_item_4 ? 'sneakers' :
                        help_item_5 ? 'joystick' :
                        help_item_6 ? 'shoes' :
                        help_item_7 ? 'bag' :
                        help_item_8 ? 'glasses' 
                    %}
                    {{ component('placeholders/product-placeholder',{
                            type: type_value,
                        })
                    }}
                </a>
                {% if not full_item %}
                    {% if help_item_1 or help_item_2 or help_item_3 or help_item_7 %}
                        <div class="labels">
                            <div class="label label-accent">
                                {% if help_item_1 or help_item_7 %}
                                    {{ "20% OFF" | translate }}
                                {% elseif help_item_2 %}
                                    {{ "Envío gratis" | translate }}
                                {% elseif help_item_3 %}
                                    {{ "35% OFF" | translate }}
                                {% endif %}
                            </div>
                        </div>
                    {% endif %}
                {% endif %}
            </div>
        </div>
        <div class="item-description{% if full_item %} col-8 col-md-9 px-3{% endif %}">
            <a href="{{ store.url }}/product/example" title="{{ "Producto de ejemplo" | translate }}" class="item-link">
                <div class="item-name mb-3">{{ "Producto de ejemplo" | translate }}</div>
                <div class="item-price-container mb-3">
                    {% set help_item_price = 
                        help_item_1 ? '9600' : 
                        help_item_2 ? '68000' :
                        help_item_3 ? '18200' :
                        help_item_4 ? '32000' :
                        help_item_5 ? '24900' :
                        help_item_6 ? '42000' :
                        help_item_7 ? '36800' :
                        help_item_8 ? '12200' 
                    %}
                    {% if item_promotional_price %}
                        {% set help_item_price_compare = 
                            help_item_1 ? '120000' : 
                            help_item_3 ? '28000' :
                            help_item_7 ? '46000'
                        %}
                    {% endif %}
                    {% if store.country != 'BR' %}
                        {% set help_item_price = help_item_price ~ "00" %}
                        {% if item_promotional_price %}
                            {% set help_item_price_compare = help_item_price_compare ~ "00" %}
                        {% endif %}
                    {% endif %}
                    <div class="item-price">{{ help_item_price | money }}</div>
                    {% if item_promotional_price %}
                        <div class="price-compare">{{ help_item_price_compare | money }}</div>
                    {% endif %}
                </div>
            </a>
            {% include 'snipplets/payments/installments.tpl' %}
        </div>
        {% if full_item %}
            </div>
        {% endif %}
    </div>
</div>