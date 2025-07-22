<div class="cart-body">
    <div class="js-ajax-cart-list cart-row cart-row-items">
        <div class="mb-4 font-medium">{{ 'Items' | translate }} <span>(</span><span class="js-cart-widget-amount">{{ "{1}" | translate(cart.items_count ) }}</span>)</span></div>
        {# Cart panel items #}
        {% if cart.items %}
            {% for item in cart.items %}
                {% include "snipplets/cart-item-ajax.tpl" %}
            {% endfor %}
        {% endif %}
    </div>
    <div class="js-empty-ajax-cart cart-row mt-4" {% if cart.items_count > 0 %}style="display:none;"{% endif %}>
        {# Cart panel empty #}
        <div class="alert alert-primary">{{ "El carrito de compras está vacío." | translate }}</div>
    </div>
    <div id="error-ajax-stock" style="display: none;">
        <div class="alert alert-warning">
            {{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}<a href="{{ store.products_url }}" class="btn-link ml-1">{{ "ver otros acá" | translate }}</a>
        </div>
    </div>
    <div class="cart-row cart-row-shipping">
        {% include "snipplets/cart-fulfillment.tpl" %}
    </div>
</div>
