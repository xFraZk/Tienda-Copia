<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />

        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

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

        {# Critical CSS needed to show first elements of store while CSS async is loading #}

        <style>
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

        {# Loads private Tienda Nube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data') }}

    </head>
    <body class="js-head-offset head-offset {% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

        {# Back to admin bar #}

        {{back_to_admin}}

        {# Page content #}

        <div class="sidebar-content d-none d-md-block">
        </div>

        <div class="main-content">
            <section class="section-password container-invert py-5 pl-2 px-md-3">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-8">
                            {% snipplet "header/header-logo.tpl" %}
                            <h2 class="mt-5">{{ message }}</h2>
                        </div>
                    </div>
                </div>
            </section>

            {# Password form #}
            <section class="page-header page-header-negative pt-5 px-2 px-md-3">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6">
                            {% embed "snipplets/forms/form.tpl" with{form_id: 'password-form', submit_text: 'Desbloquear' | translate } %}
                                {% block form_body %}

                                    {% embed "snipplets/forms/form-input.tpl" with{input_for: 'password', type_password: true, input_name: 'password', input_help: true, input_help_link: store.customer_reset_password_url, input_label_text: 'Contraseña de acceso' | translate } %}
                                        {% block input_form_alert %}
                                            {% if invalid_password == true %}
                                                <div class="alert alert-danger">{{ 'La contraseña es incorrecta.' | translate }}</div>
                                            {% endif %}
                                        {% endblock input_form_alert %}
                                    {% endembed %}

                                {% endblock %}
                            {% endembed %}
                        </div>
                    </div>
                </div>
            </section>

            {# Footer #}

            {% snipplet "footer.tpl" %}
        </div>

        {# Javascript needed to footer logos lazyload #}

        <script type="text/javascript">

            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

            {% include "static/js/external-no-dependencies.js.tpl" %}

            $('.js-password-view').click(function () {
                $(this).toggleClass('password-view');
                if($(this).hasClass('password-view')){
                   $(this).parent().find(".js-password-input").attr('type', '');
                   $(this).find(".js-eye-open, .js-eye-closed").toggle();
                } else {
                   $(this).parent().find(".js-password-input").attr('type', 'password');
                   $(this).find(".js-eye-open, .js-eye-closed").toggle();
                }
            });

        </script>
    </body>
</html>
