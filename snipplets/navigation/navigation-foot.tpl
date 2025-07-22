<ul class="footer-menu m-0 p-0">
    {% for item in menus[settings.footer_menu] %}
        <li class="footer-menu-item mb-4">
            <a class="footer-menu-link" href="{{ item.url }}" {% if item.url | is_external %}target="_blank"{% endif %}>{{ item.name }}</a>
        </li>
    {% endfor %}
</ul>
