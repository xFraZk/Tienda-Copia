{% if template == 'home' %}
    <h1 class="m-0">
{% endif %}
<div id="logo" class="logo-img-container {% if not has_logo %}hidden{% endif %}">
    {% set logo_size_class = settings.logo_size == 'small' ? 'logo-img-small' : settings.logo_size == 'medium' ? 'logo-img-medium' %}
    {{ store.logo('large') | img_tag(store.name, {class: 'logo-img transition-soft-slow ' ~ logo_size_class }) | a_tag(store.url) }}
</div>
<div id="no-logo" class="logo-text-container {% if has_logo %} hidden{% endif %}">
    <a class="logo-text h2 link-contrast" href="{{ store.url }}">{{ store.name }}</a>
</div>
{% if template == 'home' %}
    </h1>
{% endif %}