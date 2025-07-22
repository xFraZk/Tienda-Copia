<div class="js-cart-item cart-item item-product-card {% if item.product.is_non_shippable %}js-cart-item-non-shippable{% else %}js-cart-item-shippable{% endif %} {% if not loop.last %}mb-3{% endif %}" data-item-id="{{ item.id }}" data-store="cart-item-{{ item.product.id }}">
  <div class="{% if cart_page %}row align-items-md-center{% else %}form-row{% endif %}">

    {# Cart item image #}
    <div class="col-4 {% if cart_page %}col-md-1{% endif %}">
      <a href="{{ item.url }}" class="cart-item-image-container">
        <img src="{{ item.featured_image | product_image_url('medium') }}" class="cart-item-image" />
      </a>
    </div>
    <div class="cart-item-info-container pl-3 col-8 {% if cart_page %}col-md-11{% endif %}">
    {# Cart item name #}
      <div class="cart-item-info {% if cart_page %}col-12 col-md-6 h4-md mb-2 mb-md-0{% else %}mb-0{% endif %}">
        <div class="font-weight-bold mb-2">
          <a href="{{ item.url }}">
            {{ item.short_name }}
          </a>
          <small>{{ item.short_variant_name }}</small>

          {{ component(
            'cart-labels', {
              group: true,
              labels_classes: {
                group: 'my-2',
                label: 'd-inline-block label label-accent label-small label-small font-weight-normal mb-1',
              },
            })
          }}
        </div>

        {# Cart item subtotal #}
        <div class="js-cart-item-subtotal cart-item-subtotal mb-3 {% if cart_page %}col-5 col-md-3 text-right text-md-center h4-md font-weight-bold{% endif %}" data-line-item-id="{{ item.id }}">{{ item.subtotal | money }}</div>
      </div>
      
      {% if cart_page %}
        {% set cart_quantity_class = 'float-md-none m-auto ' %}
      {% else %}
        {% set cart_quantity_class = 'float-left ' %}
      {% endif %}
      <div class="container-fluid">
        <div class="row align-items-center">
          <span class="cart-item-quantity">
            {% embed "snipplets/forms/form-input.tpl" with {type_number: true, input_value: item.quantity, input_name: 'quantity[' ~ item.id ~ ']', input_custom_class: 'js-cart-quantity-input form-control-quantity form-control-quantity-small', input_append_content: true, input_group_custom_class: cart_quantity_class ~ 'form-quantity form-quantity-small mb-0', form_control_container_custom_class: '',input_data_attr: 'item-id', input_data_val: item.id, input_min: '1', input_label: false } %}
              {% block input_prepend_content %}
                <span class="js-cart-quantity-btn form-quantity-icon btn p-0" onclick="LS.minusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})">
                  {% include "snipplets/svg/minus.tpl" with {svg_custom_class: "icon-inline icon-w-12 icon-lg svg-icon-text"} %}
                </span>
              {% endblock input_prepend_content %}
              {% block input_append_content %}
                <span class="js-cart-input-spinner cart-item-spinner" style="display: none;">
                  {% include "snipplets/svg/spinner-third.tpl" with {svg_custom_class: "icon-inline icon-spin svg-icon-text"} %}
                </span>
                <span class="js-cart-quantity-btn form-quantity-icon form-quantity-icon-up btn p-0" onclick="LS.plusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})">
                  {% include "snipplets/svg/plus.tpl" with {svg_custom_class: "icon-inline icon-w-12 icon-lg svg-icon-text"} %}
                </span>
              {% endblock input_append_content %}
            {% endembed %}
          </span>

          {# Cart item delete #}
          <span>
            <button type="button" class="btn btn-link btn-link-underline ml-4" onclick="LS.removeItem({{ item.id }}{% if not cart_page %}, true{% endif %})">
              {{ "Eliminar" | translate }}
            </button>
          </span>
        </div>
      </div>
    </div>
  </div>
</div>