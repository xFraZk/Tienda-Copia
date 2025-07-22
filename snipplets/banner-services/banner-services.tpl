{% macro for_each_banner_include(template) %}
    {% set num_banners_services = 0 %}
    {% set available_banners = []%}
    {% for banner in ['banner_services_01', 'banner_services_02', 'banner_services_03'] %}
        {% set banner_services_icon = attribute(settings,"#{banner}_icon") %}
        {% set banner_services_title = attribute(settings,"#{banner}_title") %}
        {% set banner_services_description = attribute(settings,"#{banner}_description") %}
        {% set banner_services_url = attribute(settings,"#{banner}_url") %}
        {% set has_banner_services =  banner_services_title or banner_services_description %}
        {% if has_banner_services %}
            {% set num_banners_services = num_banners_services + 1 %}
            {% set available_banners = available_banners | merge([banner]) %}
        {% endif %}
    {% endfor %}
    {% for banner in available_banners %}
        {% set banner_services_title = attribute(settings,"#{banner}_title") %}
        {% set banner_services_image = "#{banner}.jpg" | has_custom_image %}
        {% set banner_services_icon = attribute(settings,"#{banner}_icon") %}
        {% set banner_services_description = attribute(settings,"#{banner}_description") %}
        {% set banner_services_url = attribute(settings,"#{banner}_url") %}
        {% include template %}
    {% endfor %}
{% endmacro %}
{% import _self as banner_services %}
{% if settings.banner_services %}
    <section class="section-informative-banners{% if settings.positive_color_background %} section-transparent container-invert{% endif %} px-2 px-md-3" data-store="banner-services">
        <div class="container-fluid">
            <div class="row">
                {{ banner_services.for_each_banner_include('snipplets/banner-services/banner-services-item.tpl') }}
            </div>
        </div>
    </section>
{% endif %}