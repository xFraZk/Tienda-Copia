{# Site Overlay #}
<div class="js-overlay site-overlay" style="display: none;"></div>


{# Header #}

<header class="js-head-main head-main" data-store="head">

    {% snipplet "header/header-utilities.tpl" %}

</header>

{% include "snipplets/notification.tpl" with {order_notification: true} %}

{% if template == 'home' %}
    {% set has_home_slider = settings.slider %}
{% endif %}
{% if template == 'category' %}
    {% set has_category_image = category.images is not empty or "banner-products.jpg" | has_custom_image %}
{% endif %}
{% if template == 'page' %}
    {% set has_page_image = page.name == settings.page_title and "us-picture.jpg" | has_custom_image %}
{% endif %}

<div class="sidebar-content{% if has_home_slider or has_page_image or has_category_image or template == 'product' %} {% if settings.ad_bar and settings.ad_text %}js-sidebar-content {% endif %}sidebar-content-transparent{% endif %}">
    {% snipplet "header/header-logo.tpl" %}
    <div class="d-md-block d-none nav-scrollable-area">
        <div class="nav-with-fixed-footer">
            <div class="nav-scrollable-area">
                <div class="nav-body">
                    {% include "snipplets/navigation/navigation-panel.tpl" with {primary_links: true} %}
                </div>
            </div>
            {% include "snipplets/navigation/navigation-panel.tpl" %}
        </div>
    </div>
</div>

{% include "snipplets/notification.tpl" with {add_to_cart: true} %}

{# Show cookie validation message #}
{% include "snipplets/notification.tpl" with {show_cookie_banner: true} %}

{# Hamburger panel #}

{% embed "snipplets/modal.tpl" with{modal_id: 'nav-hamburger',modal_class: 'invert modal-nav-hamburger pb-0', modal_position: 'right', modal_transition: 'slide', modal_width: 'full', modal_mobile_full_screen: true, modal_hide_close: 'true',modal_body_class: 'nav-body', modal_footer_class: 'pb-0 pt-3', modal_fixed_footer: true, modal_footer: true } %}
    {% block modal_body %}
        {% include "snipplets/navigation/navigation-panel.tpl" with {primary_links: true, mobile: true} %}
    {% endblock %}
    {% block modal_foot %}
        {% include "snipplets/navigation/navigation-panel.tpl" with {mobile: true} %}
    {% endblock %}
{% endembed %}
{# Notifications #}

{# Modal Search #}

{% embed "snipplets/modal.tpl" with{modal_id: 'nav-search', modal_class: 'top-sheet pb-0', modal_body_class: 'mt-0', modal_position: 'right', modal_transition: 'slide', modal_width: 'docked-md', modal_search: true } %}
    {% block modal_body %}
        {% snipplet "header/header-search.tpl" %}
    {% endblock %}
{% endembed %}

{% if not store.is_catalog %}           

    {# Cart Ajax #}

    {% if cart.items_count == 0 %}
        {% set cart_footer_visibility = 'd-none' %}
    {% else %}
        {% set cart_footer_visibility = '' %}
    {% endif %}

    {% embed "snipplets/modal.tpl" with{modal_id: 'modal-cart', modal_position: 'right', modal_transition: 'slide', modal_width: 'docked-md', modal_form_action: store.cart_url, modal_class: 'cart p-0', modal_form_class: 'js-ajax-cart-panel', modal_footer_class: 'js-visible-on-cart-filled cart-fixed-totals ' ~ cart_footer_visibility ~ "", modal_mobile_full_screen: true, modal_form_hook: 'cart-form', modal_fixed_footer: true, modal_footer: true } %}
        {% block modal_head %}
            {% block page_header_text %}{{ "Carrito de Compras" | translate }}{% endblock page_header_text %}
        {% endblock %}
        {% block modal_body %}
            {% snipplet "cart-panel.tpl" %}
        {% endblock %}
        {% block modal_foot %}
            {% include "snipplets/cart-totals.tpl" %}
        {% endblock %}
    {% endembed %}

    {% if settings.add_to_cart_recommendations %}

        {# Recommended products on add to cart #}

        {% embed "snipplets/modal.tpl" with{modal_id: 'related-products-notification', modal_class: 'bottom modal-overflow-none modal-bottom-sheet h-auto', modal_header_class: 'h3 h2-md', modal_mobile_full_screen: 'true', modal_recommendations: 'true', modal_position: 'bottom', modal_transition: 'slide', modal_header: true, modal_width: 'centered-md modal-centered-md-600px'} %}
            {% block modal_head %}
                {% block page_header_text %}{{ '¡Agregado al carrito!' | translate }}{% endblock page_header_text %}
            {% endblock %}
            {% block modal_body %}

                {# Product added info #}

                {% include "snipplets/notification-cart.tpl" with {related_products: true} %}

                {# Product added recommendations #}

                <div class="js-related-products-notification-container" style="display: none"></div>

            {% endblock %}
        {% endembed %}
    {% endif %}

{% endif %}

{# Cross selling promotion notification on add to cart #}

{% embed "snipplets/modal.tpl" with {
    modal_id: 'js-cross-selling-modal',
    modal_class: 'bottom modal-bottom-sheet h-auto overflow-none modal-body-scrollable-auto',
    modal_header: true,
    modal_header_class: 'px-3 pt-3 pb-0',
    modal_body_class: 'mt-0',
    modal_position: 'bottom',
    modal_transition: 'slide',
    modal_width: 'centered-md m-0 p-0 modal-full-width modal-md-width-400px',
    modal_close_class: 'float-right mr-2'
} %}
    {% block modal_head %}
        <h1>{{ '¡Descuento exclusivo!' | translate }}</h1>
    {% endblock %}

    {% block modal_body %}
        {# Promotion info and actions #}

        <div class="js-cross-selling-modal-body" style="display: none"></div>
    {% endblock %}
{% endembed %}