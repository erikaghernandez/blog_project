from django.shortcuts import render

# Create your views here.
#step 5 basic views

from .models import Post

def post_list(request):
	posts = Post.objects.all()
	return render(request, 'blog/post_list.html',{'posts':posts})
