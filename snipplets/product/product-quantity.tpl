{# Product quantity #}

{# Define variants and quantity col distribution depending on quickshop or product detail #}

{% if quickshop %}

    {% set quantity_visibility = 'd-md-none' %}

    {% if product.variations %}
        {% if product.variations | length == 3 %}
            {% set mobile_col, desktop_col, quantity_group_class = '6', '2', 'mb-4 mb-md-0' %}
        {% else %}
            {% set mobile_col, quantity_group_class = '12', 'mb-0' %}
        {% endif %}
        {% if product.variations | length == 2 %}
            {% set desktop_col = '8' %}
        {% elseif product.variations | length == 1 %}
            {% set desktop_col = '4' %}
        {% endif %}
    {% else %}
        {% set mobile_col, desktop_col = '' , '' %}
    {% endif %}
{% else %}
    {% set quantity_group_class, quantity_visibility = '', '' %}
    {% if product.variations %}
        {% if product.variations | length == 1 or product.variations | length == 3 %}
            {% set mobile_col, desktop_col = '6', '6' %}
        {% else %}
            {% set mobile_col, desktop_col = '12', '6' %}
        {% endif %}
    {% else %}
        {% set mobile_col, desktop_col = '12', '4' %}
    {% endif %}
{% endif %}

<div class="{% if quickshop %}mt-md-1{% endif %} col-{{ mobile_col }} col-md-{{ desktop_col }}">
    {% embed "snipplets/forms/form-input.tpl" with{type_number: true, input_value: '1', input_name: 'quantity' ~ item.id, input_custom_class: 'js-quantity-input form-control-quantity text-center', input_label_text: 'Cantidad' | translate, input_label_custom_class: quantity_visibility, input_append_content: true, input_group_custom_class: 'js-quantity ' ~ quantity_group_class ~ '', form_control_container_custom_class: '', input_min: '1', input_aria_label: 'Cambiar cantidad' | translate } %}
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
