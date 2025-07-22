{% set has_social_network = store.facebook or store.twitter or store.pinterest or store.instagram or store.tiktok or store.youtube %}
{% set has_footer_contact_info = store.phone or store.email or store.blog or store.address %}          

{% set has_footer_menu = settings.footer_menu %}
{% set has_payment_logos = settings.payments %}
{% set has_shipping_logos = settings.shipping %}
{% set has_shipping_payment_logos = has_payment_logos or has_shipping_logos %}

{% set has_seal_logos = store.afip or ebit or settings.custom_seal_code or ("seal_img.jpg" | has_custom_image) %}
<footer class="js-hide-footer-while-scrolling display-when-content-ready{% if template == 'home' or template == 'product' or template == 'account.orders' %} footer-rounded{% endif %} position-relative px-2 px-md-3 pt-5" data-store="footer">
    <div class="container-fluid">
        <div class="row">
            {% if template != 'password' %}

                {# Foot Nav #}
                {% if has_footer_menu %}
                    <div class="col-md-4 mb-4">
                        {% include "snipplets/navigation/navigation-foot.tpl" %}
                    </div>
                {% endif %}

                {% if has_shipping_payment_logos or settings.news_show or has_seal_logos %}
                    <div class="col-md-4 mb-4">
                        {# Logos Payments and Shipping #}
                        {% if has_shipping_payment_logos %}
                            <div class="footer-payments-shipping-logos mb-4">
                                {% if has_payment_logos %}
                                    {% include "snipplets/logos-icons.tpl" with {'payments': true} %}
                                {% endif %}
                                <div class="w-100 my-2"></div>
                                {% if has_shipping_logos %}
                                    {% include "snipplets/logos-icons.tpl" with {'shipping': true} %}
                                {% endif %}
                            </div>
                        {% endif %}

                        {# Newsletter #}
                        {% if settings.news_show %}
                            {% include "snipplets/newsletter.tpl" %}
                        {% endif %}

                        {# AFIP - EBIT - Custom Seal #}
                        {% if has_seal_logos %}
                            <div class="footer-seals mb-4">
                                {% if store.afip or ebit %}
                                    {% if store.afip %}
                                        <div class="footer-logo afip seal-afip">
                                            {{ store.afip | raw }}
                                        </div>
                                    {% endif %}
                                    {% if ebit %}
                                        <div class="footer-logo ebit seal-ebit">
                                            {{ ebit }}
                                        </div>
                                    {% endif %}
                                {% endif %}
                                {% if "seal_img.jpg" | has_custom_image or settings.custom_seal_code %}
                                    {% if "seal_img.jpg" | has_custom_image %}
                                        <div class="footer-logo custom-seal">
                                            {% if settings.seal_url != '' %}
                                                <a href="{{ settings.seal_url | setting_url }}" target="_blank">
                                            {% endif %}
                                                <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "seal_img.jpg" | static_url }}" class="custom-seal-img lazyload" alt="{{ 'Sello de' | translate }} {{ store.name }}"/>
                                            {% if settings.seal_url != '' %}
                                                </a>
                                            {% endif %}
                                        </div>
                                    {% endif %}
                                    {% if settings.custom_seal_code %}
                                        <div class="footer-logo custom-seal custom-seal-code">
                                            {{ settings.custom_seal_code | raw }}
                                        </div>
                                    {% endif %}
                                {% endif %}
                            </div>
                        {% endif %}
                    </div>
                {% endif %}

            {% endif %}

            {% if has_social_network or has_footer_contact_info %}
                <div class="col-md-4 mb-4">
                    {# Social #}
                    {% if has_social_network %}
                        {% include "snipplets/social/social-links.tpl" %}
                    {% endif %}
            {% if template == 'password' %}
                </div>
                <div class="col-md-4 mb-4">
            {% endif %}
                    {# Contact #}
                    {% if has_footer_contact_info %}
                        {% include "snipplets/contact-links.tpl" %}
                    {% endif %}
                </div>
            {% endif %}

        </div>
    </div>
    <div class="container-fluid p-md-0">
        <div class="row footer-legal m-md-0 align-items-center">
            <div class="col-md-4">
                {#
                La leyenda que aparece debajo de esta linea de código debe mantenerse
                con las mismas palabras y con su apropiado link a Tienda Nube;
                como especifican nuestros términos de uso: http://www.tiendanube.com/terminos-de-uso .
                Si quieres puedes modificar el estilo y posición de la leyenda para que se adapte a
                tu sitio. Pero debe mantenerse visible para los visitantes y con el link funcional.
                Os créditos que aparece debaixo da linha de código deverá ser mantida com as mesmas
                palavras e com seu link para Nuvem Shop; como especificam nossos Termos de Uso:
                http://www.nuvemshop.com.br/termos-de-uso. Se você quiser poderá alterar o estilo
                e a posição dos créditos para que ele se adque ao seu site. Porém você precisa
                manter visivél e com um link funcionando.
                #}
                {{ new_powered_by_link }}
            </div>
            <div class="col-md-8 text-md-right py-2 py-md-0 font-small">
                {{ "Copyright {1} - {2}. Todos los derechos reservados." | translate( (store.business_name ? store.business_name : store.name) ~ (store.business_id ? ' - ' ~ store.business_id : ''), "now" | date('Y') ) }}

                {% set claim_info_spacing = store.whatsapp ? 'mt-md-2 mb-md-5 pb-md-2' : 'my-md-2'%}

                {{ component('claim-info', {
                        container_classes: "ml-md-2 mt-2 " ~ claim_info_spacing,
                        divider_classes: "d-none d-md-inline-block",
                        text_classes: {text_consumer_defense: 'd-inline-block'},
                        link_classes: {
                            link_consumer_defense: "font-weight-bold d-inline-block mb-2 mb-md-0",
                            link_order_cancellation: "font-weight-bold d-block d-md-inline-block mt-1",
                        },
                    }) 
                }}
            </div>
        </div>
    </div>
</footer>