<ul class="row footer-menu m-0{% if not sidebar %} mb-4{% endif %} p-0">
    {% for sn in ['instagram', 'facebook', 'youtube', 'tiktok', 'twitter', 'pinterest'] %}
        {% set sn_url = attribute(store,sn) %}
        {% if sn_url %}
            <li class="footer-menu-item mb-4 col-6 pl-0">
                <a class="footer-menu-link" href="{{ sn_url }}" target="_blank" aria-label="{{ sn }} {{ store.name }}">
                    {{ sn }}
                </a>
            </li>
        {% endif %}
    {% endfor %}
</ul>
