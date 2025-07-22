{# Product payments details #}

{% set installments_info_base_variant = product.installments_info %}
{% set installments_info = product.installments_info_from_any_variant %}
{% if installments_info %}

    {% embed "snipplets/modal.tpl" with{
        modal_id: 'installments-modal',
        modal_position: 'bottom', 
        modal_transition: 'slide', 
        modal_header: true, 
        modal_width: 'centered', 
        modal_mobile_full_screen: 'true'} %}

        {% block modal_head %}
            {{ 'Medios de pago' | translate }}
        {% endblock %}
        {% block modal_body %}

            {# Modal header and gateways tab links #}

            {{ component('payments/payments-details',
                {
                    text_classes: {
                        text_accent: "label label-accent label-small ml-1",
                        subtitles: "h4 mb-2",
                        text_big: "font-normal",
                        text_small: "font-small",
                        align_right: "text-right",
                    },
                    spacing_classes: {
                        top_1x: "mt-1",
                        top_2x: "mt-2",
                        top_3x: "mt-3",
                        right_1x: "mr-1",
                        right_2x: "mr-2",
                        right_3x: "mr-3",
                        bottom_1x: "mb-1",
                        bottom_2x: "mb-2",
                        bottom_3x: "mb-3",
                        left_3x: "ml-3",
                    },
                    container_classes : {
                        payment_method: "box"
                    },
                    discounts_conditional_visibility: true
                })
            }}
        {% endblock %}
    {% endembed %}

{% endif %}
