<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />

        {# Preload of first image of Slider to improve LCP #}
        {% if template == 'home'%}
            {% snipplet 'preload-images.tpl' %}
        {% endif %}

        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        {# Critical CSS needed to show first elements of store while CSS async is loading #}

        <style>

            {# Font families #}

            {{ component(
                'fonts',{
                    font_weights: '300, 400,700',
                    font_settings: 'settings.font_headings, settings.font_rest'
                })
            }}

            {% include "static/css/style-critical.tpl" %}
        </style>

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        {{ 'css/style-colors.scss.tpl' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' | static_url }}" media="print" onload="this.media='all'">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>

        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {# Loads private Tiendanube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data') }}

    </head>
    <body class="js-head-offset head-offset {% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">
        {# Facebook comments on product page #}

        {% if template == 'product' %}

            {# Pinterest share button JS #}
            {{ pin_js }}

        {% endif %}

        {# Back to admin bar #}

        {{back_to_admin}}

        {# Header = Advertising + Nav + Logo + Search + Ajax Cart #}

        {% snipplet "header/header.tpl" %}

        <div class="main-content{% if template == 'home' and not settings.slider %} pt-md-4{% endif %}">
            {# Advertising #}

            {% if settings.ad_bar and settings.ad_text %}
                {% snipplet "header/header-advertising.tpl" %}
            {% endif %}

            {# Page content #}

            {% template_content %}

            {# Footer #}

            {% snipplet "footer.tpl" %}

            {% if cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

                {# Minimum used for free shipping progress messages. Located on header so it can be accesed everywhere with shipping calculator active or inactive #}

                <span class="js-ship-free-min hidden" data-pricemin="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
                <span class="js-free-shipping-config hidden" data-config="{{ cart.free_shipping.allFreeConfigurations }}"></span>
                <span class="js-cart-subtotal hidden" data-priceraw="{{ cart.subtotal }}"></span>
                <span class="js-cart-discount hidden" data-priceraw="{{ cart.promotional_discount_amount }}"></span>
            {% endif %}

        </div>

        {# Modals overlay #}

        <div class="js-modal-overlay modal-overlay" style="display: none;"></div>

        {# Quickshop modal #}

        {% snipplet "grid/quick-shop.tpl" %}

        {# WhatsApp chat button #}

        {% snipplet "whatsapp-chat.tpl" %}


        {#/*============================================================================
            #Javascript: Needed after HTML loads
        ==============================================================================*/#}

        {# Javascript used in the store #}

        <script type="text/javascript">

            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

            {% include "static/js/external-no-dependencies.js.tpl" %}

            {# LS.ready.then function waits to Jquery and private Tiendanube JS to be loaded before executing what´s inside #}

            LS.ready.then(function(){

                {# Libraries that requires Jquery to work #}

                {% include "static/js/external.js.tpl" %}

                {# Specific store JS functions: product variants, cart, shipping, etc #}

                {% include "static/js/store.js.tpl" %}
            });
        </script>

        {# Google reCAPTCHA on register page #}

        {% if template == 'account.register' %}
            {% if not store.hasContactFormsRecaptcha() %}
                {{ '//www.google.com/recaptcha/api.js' | script_tag(true) }}
            {% endif %}
            <script type="text/javascript">
                var recaptchaCallback = function() {
                    $('.js-recaptcha-button').prop('disabled', false);
                };
            </script>
        {% endif %}

        {# Store external codes added from admin #}

        <script>
            LS.ready.then(function() {
                var trackingCode = $.parseHTML('{{ store.assorted_js| escape("js") }}', document, true);
                $('body').append(trackingCode);
            });
        </script>

    </body>
</html>
