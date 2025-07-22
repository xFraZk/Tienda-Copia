{% set has_featured = has_featured | default(false) and sections.primary.products %}
{% set has_sale = has_sale | default(false) and sections.sale.products %}
{% set has_category = has_category | default(false) %}

{% if has_featured or has_sale or has_category %}
    <section class="{% if has_category %}section-category-home{% else %}section-featured-home{% endif %} {% if settings.positive_color_background %}section-transparent mb-0 {% if has_featured %}py-0 {% endif %}{% endif %}{% if has_featured %}px-2{% else %}pl-2{% endif %} px-md-3" data-store="home-products-{% if has_featured %}featured{% elseif has_sale %}sale{% else %}category{% endif %}">
        {% if has_featured %}
            {% include 'snipplets/home/home-featured-grid.tpl' with {'featured_slider': true} %}
        {% endif %}
        {% if has_sale %}
            {% include 'snipplets/home/home-featured-grid.tpl' with {'sale_slider': true} %}
        {% endif %}
        {% if has_category %}
            {% include 'snipplets/home/home-featured-grid.tpl' with {'category_slider': true} %}
        {% endif %}
    </section>
{% endif %}
