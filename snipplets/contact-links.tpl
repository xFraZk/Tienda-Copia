{# /*============================================================================
  #Contact links
==============================================================================*/#}

<ul class="contact-info mb-5">
    {% if store.whatsapp %}
        <li class="contact-item">
            <a href="{{ store.whatsapp }}" class="contact-link">{{ "WhatsApp" | translate }}: {{ store.whatsapp |trim('https://wa.me/') }}</a>
        </li>
    {% endif %}
    {% if store.phone %}
        <li class="contact-item">
            <a href="tel:{{ store.phone }}" class="contact-link">{{ store.phone }}</a>
        </li>
    {% endif %}
    {% if store.email %}
        <li class="contact-item">
            <a href="mailto:{{ store.email }}" class="contact-link">{{ store.email }}</a>
        </li>
    {% endif %}
    {% if not phone_and_mail_only %}
        {% if store.address and not is_order_cancellation %}
            <li class="contact-item">
                {{ store.address }}
            </li>
        {% endif %}
        {% if store.blog %}
            <li class="contact-item">
                <a target="_blank" href="{{ store.blog }}" class="contact-link">{{ "Visita nuestro Blog!" | translate }}</a>
            </li>
        {% endif %}
    {% endif %}
</ul>
