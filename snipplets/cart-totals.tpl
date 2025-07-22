{# Cart total #}

{# IMPORTANT Do not remove this hidden subtotal, it is used by JS to calculate cart total #}
<div class="subtotal-price hidden" data-priceraw="{{ cart.total }}"></div>

{# Used to assign currency to total #}
<div id="store-curr" class="hidden">{{ cart.currency }}</div>

{% if cart_page %}

  {# Check if store has free shipping without regions or categories #}

  {% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

  {% if has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

    {# includes free shipping progress bar: only if store has free shipping with a minimum #}

    {% include "snipplets/shipping/shipping-free-rest.tpl" %}
  {% endif %}

{% endif %}

<div class="js-visible-on-cart-filled js-has-new-shipping w-100" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>
  <div class="w-100">
    <div class="js-toggle-cart-total-details">
      <div class="js-cart-total-container" data-store="cart-total">
        <h4 class="row align-items-center mb-0 h-font-body text-uppercase">
          <div class="col">
            <span class="mr-1 font-weight-normal">{{ "Total" | translate }}:</span>
            <span class="js-cart-total {% if cart.free_shipping.cart_has_free_shipping %}js-free-shipping-achieved{% endif %} {% if cart.shipping_data.selected %}js-cart-saved-shipping{% endif %}">{{ cart.total | money }}</span>
          </div>
          <div class="col-auto">
            {% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "js-cart-toggle-icon icon-inline icon-lg svg-icon-text"} %}
            <span class="js-cart-toggle-icon" style="display: none;">
              {% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: "icon-inline icon-lg svg-icon-text"} %}
            </span>
          </div>
        </h4>
        {# IMPORTANT Do not remove this hidden total, it is used by JS to calculate cart total #}
        <div class='total-price hidden'>{{ "Total" | translate }}: {{ cart.total | money }}</div>
      </div>
    </div>
    <div class="js-toggle-cart-totals full-width-container" style="display: none;">

      {{ component('payment-discount-price', {
          visibility_condition: settings.payment_discount_price,
          location: 'cart',
          container_classes: 'mt-1',
          text_classes: {
            price: 'font-weight-bold',
          },
        }) 
      }}
      {% if not settings.payment_discount_price %}
        {% include "snipplets/payments/installments.tpl" with {'product': false} %}
      {% endif %}
      {# Cart popup subtotal #}
      <div class="mt-4 mb-3 row no-gutters font-medium" data-store="cart-subtotal">
        <span class="col text-uppercase">{{ "Subtotal" | translate }}:</span>
        <strong class="js-ajax-cart-total js-cart-subtotal {% if not cart_page %}col{% endif %} text-right" data-priceraw="{{ cart.subtotal }}">{{ cart.subtotal | money }}</strong>
      </div>

      {# Cart popup promos #}
      <div class="js-total-promotions font-medium mb-3">
        <span class="js-promo-discount" style="display:none;"> {{ "Descuento" | translate }}</span>
        <span class="js-promo-in text-uppercase" style="display:none;">{{ "en" | translate }}</span>
        <span class="js-promo-all text-uppercase" style="display:none;">{{ "todos los productos" | translate }}</span>
        <span class="js-promo-buying text-uppercase" style="display:none;"> {{ "comprando" | translate }}</span>
        <span class="js-promo-units-or-more text-uppercase" style="display:none;"> {{ "o más" | translate }}</span>
        {% for promotion in cart.promotional_discount.promotions_applied %}
          {% if(promotion.scope_value_id) %}
            {% set id = promotion.scope_value_id %}
          {% else %}
            {% set id = 'all' %}
          {% endif %}
            <span class="js-total-promotions-detail-row row" id="{{ id }}">
              <span class="col text-uppercase">
                {% if promotion.discount_script_type != "custom" %}
                  {% if promotion.discount_script_type == "NAtX%off" %}
                    {{ promotion.selected_threshold.discount_decimal_percentage * 100 }}% OFF
                  {% elseif promotion.isBuyXPayY %}
                    {{ promotion.buy }}x{{ promotion.pay }}
                  {% elseif promotion.isCrossSelling %}
                    {{ "Descuento" | translate }}
                  {% else %}
                    {{ promotion.discount_script_type }}
                  {% endif %}

                  {{ "en" | translate }} {% if id == 'all' %}{{ "todos los productos" | translate }}{% else %}{{ promotion.scope_value_name }}{% endif %}

                  {% if promotion.discount_script_type == "NAtX%off" %}
                    <span>{{ "Comprando {1} o más" | translate(promotion.selected_threshold.quantity) }}</span>
                  {% endif %}
                {% else %}
                  {{ promotion.scope_value_name }}
                {% endif %}
                :
              </span>
              <span class="col text-right text-accent font-weight-bold">-{{ promotion.total_discount_amount_short }}</span>
            </span>
        {% endfor %}
      </div>

      {% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}

      <div id="shipping-cost-container" class="js-fulfillment-info js-visible-on-cart-filled js-shipping-cost-table row mb-3 font-medium" {% if cart.items_count == 0 or (not cart.has_shippable_products) %}style="display:none;"{% endif %}>
        <span class="col-auto text-uppercase">{{ 'Envío:' | translate }}</span>
        <span id="shipping-cost" class="col text-right opacity-40">
          {% if show_calculator_on_cart %}
              {{ "Calculalo arriba para verlo" | translate }}
          {% else %}
            {{ "El costo se calcula más adelante" | translate }}
          {% endif %}
        </span>
        <span class="col text-right opacity-40 js-calculating-shipping-cost" style="display: none">
          {{ "Calculando" | translate }}...
        </span>
        <span class="col text-right opacity-40 js-shipping-cost-empty" style="display: none">
            {% if cart_page %}
              <span class="d-none d-md-block">{{'Calcular para verlo' | translate }}</span>
            {% endif %}
            {% if cart_page %}
              <span class="d-block d-md-none">
            {% endif %}
                {{ "Calculalo arriba para verlo" | translate }}
            {% if cart_page %}
              </span>
            {% endif %}
        </span>
      </div>
    </div>

    <div class="container-fluid mt-3">

      {# No stock alert #}

      <div id="error-ajax-stock" class='alert alert-warning' role='alert' style="display:none;">
         {{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}<a href="{{ store.products_url }}" class="btn-link">{{ "ver otros acá" | translate }}</a>
      </div>

      {# Cart panel CTA #}
      
      {% set cart_total = (settings.cart_minimum_value * 100) %}

      {# Cart CTA Module for cart popup or cart page #}

      {% if cart_page %}
        {% if cart.checkout_enabled %}
          <input id="go-to-checkout" class="btn btn-primary btn-block mb-3" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}"/>
        {% else %}

          {# Cart minium alert #}

          <div class="alert alert-warning mt-4">
            {{ "El monto mínimo de compra es de {1} sin incluir el costo de envío" | t(cart_total | money) }}
          </div>
        {% endif %}
      {% else %}
        <div class="js-ajax-cart-submit row" {{ not cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-submit-div">
          <input class="btn btn-primary btn-block" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}"/>
        </div>

        {# Cart minium alert #}

        <div class="js-ajax-cart-minimum alert alert-warning mt-4" {{ cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-minumum-div">
          {{ "El monto mínimo de compra es de {1} sin incluir el costo de envío" | t(cart_total | money) }}
        </div>
        <input type="hidden" id="ajax-cart-minimum-value" value="{{ cart_total }}"/>
      {% endif %}

    </div>
  </div>
</div>
