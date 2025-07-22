{# Detect presence of features that remove empty placeholders #}

{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_category_banners = settings.banner_01_show or settings.banner_02_show or settings.banner_03_show %}
{% set has_brands = settings.brands and settings.brands is not empty %}
{% set has_category_products = settings.category_products_url %}
{% set has_video = settings.video_embed %}
{% set has_informative_banners = settings.banner_services and (settings.banner_services_01_title or settings.banner_services_01_description or settings.banner_services_02_title or settings.banner_services_02_description or settings.banner_services_03_title or settings.banner_services_03_description) %}
{% set has_instafeed = store.instagram and settings.show_instafeed and store.hasInstagramToken() %}

{% set show_help = not (has_main_slider or has_mobile_slider or has_category_banners or has_brands or has_category_products or has_video or has_informative_banners or has_instafeed) and not has_products and not params.preview %}

{% set show_component_help = params.preview %}

{% if not params.preview %}
    {% set admin_link = is_theme_draft ? '/admin/themes/settings/draft/' : '/admin/themes/settings/active/' %}
{% endif %}

{#  **** Features Order ****  #}
{% set newArray = [] %}

<div class="js-home-sections-container">
    {% for i in 0..9 %}
        {% set section = 'home_order_position_' ~ i %}
        {% set section_select = attribute(settings,"#{section}") %}

        {% if section_select not in newArray %}

            {% include 'snipplets/home/home-section-switch.tpl' %}
            {% set newArray = newArray|merge([section_select]) %}

        {% endif %}

    {% endfor %}

    {#  **** Hidden Sections ****  #}
    {% if show_component_help %}
        <div style="display:none">
            {% for section_select in ['slider', 'banners', 'products', 'brands', 'category', 'video', 'informatives', 'sale', 'instafeed'] %}
                {% if section_select not in newArray %}
                    {% include 'snipplets/home/home-section-switch.tpl' %}
                {% endif %}
            {% endfor %}
        </div>
    {% endif %}
</div>
