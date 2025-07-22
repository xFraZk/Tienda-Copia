
{% embed "snipplets/page-header.tpl" %}
    {% block page_header_text %}{{ "Mis direcciones" | translate }}{% endblock page_header_text %}
{% endembed %}

{# User addresses listed #}

<section class="account-page px-2 px-md-3">
    <div class="container">
        <div class="row pt-3">
            {% for address in customer.addresses %}
                {% if loop.first %}
                    {# User addresses listed - Main Address #}
                    <div class="col-md-4 text-left">
                        <p class="label-title mb-3">{{ 'Principal' | translate }}</p>
                        <div class="row">
                {% elseif loop.index == 2 %}
                    {# User addresses listed - Other Addresses #}
                    <div class="col-md-8">
                        <p class="label-title mb-3">{{ 'Otras direcciones' | translate }}</p>
                        <div class="row">
                {% endif %}
                            <div class="col{% if not loop.first %}-md-4 {% endif %} mb-4">
                                <p class="font-weight-light">{{ address | format_address }}</p>
                                <p>
                                    {{ 'Editar' | translate | a_tag(store.customer_address_url(address), {class: 'btn-link'}) }}
                                </p>
                                {% if loop.first %}
                                    <a class="btn btn-secondary btn-small my-3" href="{{ store.customer_new_address_url }}"> {{ 'Agregar una nueva dirección' | translate }}</a>
                                {% endif %}
                            </div>
                {% if loop.first %}
                        </div>
                    </div>
                {% elseif loop.last %}
                        </div>
                    </div>
                {% endif %}
            {% endfor %}
        </div>
    </div>
</section>
