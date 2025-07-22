{# Define contitions to show shipping calculator and store branches on cart #}

{% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}
{% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}


{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

{% if has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

  <div class="row d-block px-3 {% if show_cart_fulfillment %}pt-5 container-invert{% else %}pt-4 mt-2 pb-5{% endif %}">

    {# includes free shipping progress bar: only if store has free shipping with a minimum #}

    {% include "snipplets/shipping/shipping-free-rest.tpl" %}
  </div>
{% endif %}

{% if cart_page %}
  <div class="container p-0">
    <div class="row">
      <div class="col-12 col-md-5">
{% endif %}
      {% if show_cart_fulfillment %}
        <div class="js-fulfillment-info js-allows-non-shippable row" {% if not cart.has_shippable_products %}style="display: none"{% endif %}>
          <div class="js-visible-on-cart-filled js-has-new-shipping js-shipping-calculator-container cart-shipping-container container-invert px-3 {% if has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}pt-3{% endif %} w-100">

            {# Saved shipping not available #}

            <div class="js-shipping-method-unavailable alert alert-warning" style="display: none;">
              <div>
                <strong>{{ 'El medio de envío que habías elegido ya no se encuentra disponible para este carrito. ' | translate }}</strong>
              </div>
              <div>
                {{ '¡No te preocupes! Podés elegir otro.' | translate}}
              </div>
            </div>

            {# Shipping calculator and branch link #}

            <div id="cart-shipping-container" {% if cart.items_count == 0 %} style="display: none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

              {# Used to save shipping #}

              <span id="cart-selected-shipping-method" data-code="{{ cart.shipping_data.code }}" class="hidden">{{ cart.shipping_data.name }}</span>

              {# Shipping Calculator #}

              {% if store.has_shipping %}
                {% include "snipplets/shipping/shipping-calculator.tpl" with {'product_detail': false} %}
              {% endif %}

              {# Store branches #}

              {% if store.branches %}

                {# Link for branches #}

                {% include "snipplets/shipping/branches.tpl" with {'product_detail': false} %}
              {% endif %}
            </div>
          </div>
        </div>
      {% endif %}
{% if cart_page %}
      </div>
    </div>
  </div>
{% endif %}