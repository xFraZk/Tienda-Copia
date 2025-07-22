<div class="col-md text-center mb-4 m-md-0">
    {% if settings.positive_color_background %}
        {% set service_icon_class = 'icon-inline icon-5x svg-icon-invert my-3' %}
     {% else %}
        {% set service_icon_class = 'icon-inline icon-5x svg-icon-text my-3' %}
    {% endif %}
    {% if banner_services_icon == 'image' and banner_services_image %}
        <img class="service-item-image lazyautosizes lazyload blur-up-big mb-3" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ "#{banner}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{banner}.jpg" | static_url | settings_image_url('huge') }} 640w" data-sizes="auto" data-expand="-10" {% if banner_services_title %}alt="{{ banner_services_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
    {% elseif banner_services_icon == 'shipping' %}
        {% include "snipplets/svg/map-marker.tpl" with {svg_custom_class: service_icon_class} %}
    {% elseif banner_services_icon == 'card' %}
        {% include "snipplets/svg/credit-card.tpl" with {svg_custom_class: service_icon_class} %}
    {% elseif banner_services_icon == 'security' %}
        {% include "snipplets/svg/lock.tpl" with {svg_custom_class: service_icon_class} %}
    {% elseif banner_services_icon == 'returns' %}
        {% include "snipplets/svg/sync.tpl" with {svg_custom_class: service_icon_class} %}
    {% elseif banner_services_icon == 'whatsapp' %}
        {% include "snipplets/svg/whatsapp-line.tpl" with {svg_custom_class: service_icon_class} %}
    {% elseif banner_services_icon == 'promotions' %}
        {% include "snipplets/svg/tag.tpl" with {svg_custom_class: service_icon_class} %}
    {% elseif banner_services_icon == 'cash' %}
        {% include "snipplets/svg/dollar-sign.tpl" with {svg_custom_class: service_icon_class} %}
    {% endif %}
    {% if banner_services_url %}
        <a href="{{ banner_services_url | setting_url }}">
    {% endif %}
    <h3 class="h2 mb-2">{{ banner_services_title }}</h3>
    <p>{{ banner_services_description }}</p>
    {% if banner_services_url %}
        </a>
    {% endif %}
</div>
