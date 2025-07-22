{% if settings.video_embed %}
    <section class="section-video-home px-2 px-md-3" data-store="home-video">
        <div class="container-fluid">
            <div class="row">
                <div class="col">
                    {% include 'snipplets/video-item.tpl' %}
                </div>
            </div>
        </div>
    </section>
{% endif %}