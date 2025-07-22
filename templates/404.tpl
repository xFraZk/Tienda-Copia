{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{% if not show_help %}
    {% embed "snipplets/page-header.tpl" %}
        {% block page_header_text %}{{ "Error" | translate }} - {{ "404" | translate }}{% endblock page_header_text %}
    {% endembed %}
{% endif %}

<section id="404">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12 text-center">
                <h2 class="mb-1 h-font-body">{{ "La página que estás buscando no existe." | translate }}</h2></br>
            </div>
        </div>
        {% set related_products = sections.primary.products | take(4) | shuffle %}
        {% if related_products | length > 1 %}
            <div class="row">
                <div class="col-12 text-center h3 mb-3 h-font-body">
                    {{ "Quizás te interesen los siguientes productos." | translate }}
                </div>
            </div>
            <div class="row mt-3">
                {% for related in related_products %}
                    {% include 'snipplets/grid/item.tpl' with {product : related} %}
                {% endfor %}
            </div>
        {% endif %}
    </div>
</section>

{# Here we will add an example as a help, you can delete this after you upload your products #}
{% if show_help %}
    <div id="product-example">
        {% snipplet 'defaults/show_help_product.tpl' %}
    </div>
{% endif %}