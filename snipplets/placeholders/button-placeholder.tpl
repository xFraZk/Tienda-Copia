<div class="js-addtocart js-addtocart-placeholder btn btn-primary btn-transition disabled {{ custom_class }}" style="display: none;">
    <div class="d-inline-block">
        {% if item %}
            <span class="js-addtocart-text btn-transition-start transition-container active">
                {% include "snipplets/svg/shopping-bag.tpl" with {svg_custom_class: "icon-inline icon-lg svg-icon-invert"} %}
            </span>
        {% else %}
            <span class="js-addtocart-text transition-container btn-transition-start active">
                {{ 'Agregar al carrito' | translate }}
            </span>
        {% endif %}
        <span class="js-addtocart-success transition-container btn-transition-success">
            {% if item %}
                {% include "snipplets/svg/check-double.tpl" with {svg_custom_class: "icon-inline icon-lg svg-icon-invert"} %}
            {% else %}
                {{ '¡Listo!' | translate }}
            {% endif %}
        </span>
        <div class="js-addtocart-adding transition-container btn-transition-progress {% if item %}mt-0 pr-3{% endif %}">
            <i class="spinner {% if item %}spinner-small{% endif %} col-4 offset-4"></i>
        </div>
    </div>
</div>

