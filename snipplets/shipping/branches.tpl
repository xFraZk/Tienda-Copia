<div class="{% if store.branches|length > 1 %}js-toggle-branches{% endif %} w-100" data-store="branches">
    <div class="h4 {% if store.branches|length > 1 %}mb-1{% endif %}"> 
        {% if store.branches|length > 1 %}
            {{ 'Nuestros locales' | translate }}
        {% else %}
            {{ 'Nuestro local' | translate }}
        {% endif %}
    </div>
    {% if store.branches|length > 1 %}
        <a href="#" class="btn-link-capitalize d-inline">
            <span class="js-see-branches">
                {{ 'Ver opciones' | translate }}
            </span>
            {% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "js-see-branches icon-inline ml-1"} %}

            <span class="js-hide-branches" style="display: none;">
                {{ 'Ocultar opciones' | translate }}
                {% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: "icon-inline ml-1"} %}
            </span>
        </a>
    {% endif %}
</div>

{# Store branches #}
    
<ul class="js-store-branches-container list-unstyled mt-4 {% if product_detail %}list-readonly{% else %}radio-button-container full-width-container{% endif %}" {% if store.branches|length > 1 %}style="display: none;"{% endif %}>

    {% for branch in store.branches %}
        <li class="{% if product_detail %}list-item box{% else %}radio-button-item{% endif %}" data-store="branch-item-{{ branch.code }}">

            {# If cart use radiobutton #}
            
            {% if not product_detail %}
                <label class="js-shipping-radio js-branch-radio radio-button" data-loop="branch-radio-{{loop.index}}">
                    <input 
                    class="js-branch-method {% if cart.shipping_data.code == branch.code %} js-selected-shipping-method {% endif %} shipping-method" 
                    data-price="0" 
                    {% if cart.shipping_data.code == branch.code %}checked{% endif %} type="radio" 
                    value="{{branch.code}}" 
                    data-name="{{ branch.name }} - {{ branch.extra }}"
                    data-code="{{branch.code}}" 
                    data-cost="{{ 'Gratis' | translate }}"
                    name="option" 
                    style="display:none">
                    <span class="radio-button-content box">
                        <div class="radio-button-icons-container">
                            <span class="radio-button-icons">
                                <span class="radio-button-icon unchecked"></span>
                                <span class="radio-button-icon checked"></span>
                            </span>
                        </div>
                        <div class="radio-button-label">
            {% endif %}
                            <div class="{% if product_detail %}list-item-content{% else %}radio-button-text{% endif %}"> 
                                <div class="h5 shipping-price mb-2">
                                    {{ 'Gratis' | translate }}
                                </div>
                                <div class="font-small">
                                    {{ branch.name }} <span class="ml-1">{{ branch.extra }}</span>
                                </div>
                            </div>
            {% if not product_detail %}
                        </div>
                    </span>
                </label>
            {% endif %}
        </li>
    {% endfor %}
</ul>
