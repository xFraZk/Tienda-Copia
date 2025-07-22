{% set has_social_or_languages_links = languages | length > 1 or (store.facebook or store.twitter or store.pinterest or store.instagram or store.tiktok or store.youtube) %}
{% if has_social_or_languages_links %}
    {% if languages | length > 1 %}
        <div class="languages mb-4">
            {% for language in languages %}
                {% set class = language.active ? "" : "opacity-50" %}
                <a href="{{ language.url }}" class="{{ class }}">
                    <img class="lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ language.country | flag_url }}" alt="{{ language.name }}" />
                </a>
            {% endfor %}
        </div>
    {% endif %}

    {% if store.facebook or store.twitter or store.pinterest or store.instagram or store.tiktok or store.youtube %}
        {% include "snipplets/social/social-links.tpl" with {'sidebar': true} %}
    {% endif %}
{% endif %}