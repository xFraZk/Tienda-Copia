{# Cookie validation #}

{% if show_cookie_banner and not params.preview %}
    <div class="js-notification js-notification-cookie-banner notification notification-secondary notification-fixed-bottom notification-above col-12 col-md-5 px-md-2" style="display: none;">
        <div class="mb-4">{{ 'Al navegar por este sitio <strong>aceptás el uso de cookies</strong> para agilizar tu experiencia de compra.' | translate }}</div>
        <div class="text-center">
            <a href="#" class="js-notification-close js-acknowledge-cookies btn btn-primary py-2">{{ "Entendido" | translate }}</a>
        </div>
    </div>
{% endif %}

{# Order notification #}

{% if order_notification and status_page_url %}
    <div class="js-notification js-notification-status-page notification notification-secondary notification-fixed-right notification-above col-auto ml-3" data-url="{{ status_page_url }}" style="display:none;">
        <div class="container">
            <div class="row">
                <div class="col">
                    <a class="d-block mr-3" href="{{ status_page_url }}"><span class="btn btn-link-underline">{{ "Seguí acá" | translate }}</span> {{ "tu última compra" | translate }}</a>
                    <a class="js-notification-close js-notification-status-page-close notification-close d-flex" href="#">
                        {% include "snipplets/svg/times.tpl" with {svg_custom_class: "icon-inline icon-md"} %}
                    </a>
                </div>
            </div>
        </div>
    </div>
{% endif %}

{# Add to cart notification #}

{% if add_to_cart %}
    {% include "snipplets/notification-cart.tpl" %}
{% endif %}