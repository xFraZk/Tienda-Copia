{% set notification_wrapper_classes = related_products ? 'row mb-4' : 'js-alert-added-to-cart notification-floating notification-hidden' %}

<div class="{{ notification_wrapper_classes }}" {% if not related_products %}style="display: none;"{% endif %}>
    <div class="{% if related_products %}col-12 col-md mb-3 mb-md-0{% else %}notification notification-invert position-relative{% endif %}">
        {% if not related_products %}
            <div class="js-cart-notification-close notification-close">
                {% include "snipplets/svg/times.tpl" with {svg_custom_class: "icon-inline svg-icon-ivert"} %}
            </div>
        {% endif %}
        <div class="js-cart-notification-item row" data-store="cart-notification-item">
            <div class="{% if related_products %}col-md-4 col-3{% else %}col-4{% endif %} pr-0 overflow-hidden">
                <div class="cart-item-image-container">
                    <img src="" class="js-cart-notification-item-img img-fluid cart-item-image" />
                </div>
            </div>
            <div class="{% if related_products %}col-md-8 col-9{% else %}col-8{% endif %} text-left pb-3">
                <div class="mb-1 mt-2">
                    <span class="js-cart-notification-item-name"></span>
                    <span class="js-cart-notification-item-variant-container" style="display: none;">
                        (<span class="js-cart-notification-item-variant"></span>)
                    </span>
                </div>
                <div class="mb-1">
                    <span class="js-cart-notification-item-quantity"></span>
                    <span> x </span>
                    <span class="js-cart-notification-item-price"></span>
                </div>
                {% if not related_products %}
                    <strong>{{ '¡Agregado con éxito!' | translate }}</strong>
                {% endif %}
            </div>
        </div>
    {% if related_products %}
    </div>
    {% endif %}
        <div class="{% if related_products %}col-12 col-md-auto{% else %}notification-invert-footer{% endif %}">
            <div class="row {% if related_products %}h4 h-font-body{% else %}font-medium{% endif %} mb-3">
                <span class="col-auto text-left">
                    <strong>{{ "Total" | translate }}</strong> 
                    (<span class="js-cart-widget-amount">
                        {{ "{1}" | translate(cart.items_count ) }} 
                    </span>
                    <span class="js-cart-counts-plural" style="display: none;">
                        {{ 'productos' | translate }}):
                    </span>
                    <span class="js-cart-counts-singular" style="display: none;">
                        {{ 'producto' | translate }}):
                    </span>
                </span>
                <strong class="js-cart-total col text-right">{{ cart.total | money }}</strong>
            </div>
            <a href="#" class="{% if related_products %}js-modal-close js-open-cart-modal{% else %}js-cart-notification-close js-modal-open{% endif %} js-fullscreen-modal-open btn btn-primary btn-medium w-100 d-inline-block" {% if not related_products %}data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"{% endif %}>
                {{'Ver carrito' | translate }}
            </a>
        </div>
    {% if not related_products %}
    </div>
    {% endif %}
</div>