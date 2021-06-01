
from django.http import HttpResponse
from django.template import engines

def index(request):
    engine = engines["django"]
    template = engine.from_string("<html><body><form method=get><input name=injection><br><input type=submit></form><br>"+request.GET.get("injection")+"</body></html>")
    return HttpResponse(template.render({}, request))
