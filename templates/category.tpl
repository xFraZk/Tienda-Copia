{% set has_filters_available = has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}


{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}
{% paginate by 12 %}

{% if not show_help %}

    {% if (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
        {% include 'snipplets/category-banner.tpl' %}
    {% endif %}


    {% embed "snipplets/page-header.tpl" with { breadcrumbs: false } %}
        {% block page_header_text %}{{ category.name }}{% endblock page_header_text %}
    {% endembed %}

    <section class="category-body position-relative px-2 px-md-3">
        <div class="container-fluid">
            {% if products %}
                {% set columns = settings.grid_columns %}
                {% if has_filters_available %}
                    <div class="category-controls">
                        <a href="#" class="js-modal-open js-fullscreen-modal-open filter-link" data-toggle="#nav-filters" data-modal-url="modal-fullscreen-filters">
                            {% include "snipplets/svg/filter.tpl" with {svg_custom_class: "icon-inline icon-2x svg-icon-invert ml-1"} %}
                        </a>
                        {% embed "snipplets/modal.tpl" with{modal_id: 'nav-filters', modal_class: 'filters', modal_position: 'right', modal_transition: 'slide', modal_width: 'docked-md', modal_mobile_full_screen: true} %}
                            {% block modal_head %}
                                <h1>{{'Filtros' | translate }}</h1>
                            {% endblock %}
                            {% block modal_body %}
                                {% snipplet "grid/sort-by.tpl" %}
                                {% if filter_categories is not empty %}
                                    {% snipplet "grid/categories.tpl" %}
                                {% endif %}
                                {% if product_filters is not empty %}
                                    {% snipplet "grid/filters.tpl" %}
                                {% endif %}
                                <div class="js-filters-overlay filters-overlay" style="display: none;">
                                    <div class="filters-updating-message">
                                        <h3 class="js-applying-filter" style="display: none;">{{ 'Aplicando filtro...' | translate }}</h3>
                                        <h3 class="js-removing-filter" style="display: none;">{{ 'Borrando filtro...' | translate }}</h3>
                                    </div>
                                </div>
                            {% endblock %}
                        {% endembed %}
                    </div>
                {% endif %}
            {% endif %}
            <div class="row">
                {% include "snipplets/grid/filters.tpl" with {applied_filters: true} %}
            </div>
            {% if products %}
                <div class="js-product-table row" data-store="category-grid-{{ category.id }}">
                    {% include 'snipplets/product_grid.tpl' %}
                </div>
                {% include 'snipplets/grid/pagination.tpl' with {'pages': pages, 'infinite_scroll': true } %}
            {% else %}
                <p class="mt-4 font-weight-bold">
                    {{(has_filters_enabled ? "No tenemos resultados para tu búsqueda. Por favor, intentá con otros filtros." : "Próximamente") | translate}}
                </p>
            {% endif %}
        </div>
    </section>
{% elseif show_help %}
    {# Category Placeholder #}
    {% include 'snipplets/defaults/show_help_category.tpl' %}
{% endif %}
