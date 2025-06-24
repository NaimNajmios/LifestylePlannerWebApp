<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="header.jsp" />

<!-- Articles Section Begin -->
<section class="classes-section spad" style="margin: 50px 0;">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2>Latest Articles</h2>
                </div>
            </div>
        </div>

        <div class="search-bar text-center mb-4">
            <input type="text" id="search-input" class="form-control" placeholder="Search articles..." style="display:inline-block; width:300px; margin-right:10px;">
        </div>

        <div class="sort-btn text-center mb-4">
            <button id="sort-btn" class="primary-btn">
                <i id="sort-icon" class="fa-solid fa-arrow-down"></i>
                Sort by Date (Latest First)
            </button>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-4">
                <i class="fa-solid fa-triangle-exclamation"></i> ${error}
            </div>
        </c:if>

        <div id="articles-container">
            <div class="row" id="articles-row">
                <c:forEach var="article" items="${articles}">
                    <div class="col-lg-4 col-md-6 mb-4 article-item" data-date="${article.publishedAt}">
                        <div class="single-classes-item">
                            <a href="${article.url}" target="_blank">
                                <img src="${article.image != null ? article.image : 'https://via.placeholder.com/300x180?text=No+Image'}" alt="${article.title}" class="article-image" style="cursor:pointer;">
                            </a>
                            <div class="classes-text">
                                <h4><i class="fa-solid fa-newspaper"></i>
                                    <a href="${article.url}" target="_blank" style="color:inherit; text-decoration:none; cursor:pointer;">${article.title}</a>
                                </h4>
                                <p class="article-desc">
                                    <c:choose>
                                        <c:when test="${not empty article.description}">
                                            ${article.description}
                                        </c:when>
                                        <c:otherwise>
                                            No description available.
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="article-meta">
                                    <span><i class="fa-regular fa-calendar"></i>
                                        <c:out value="${fn:substring(article.publishedAt, 0, 10)}"/>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</section>
<!-- Articles Section End -->

<style>
/* Multiline truncation for article description */
.article-desc {
    color: #666;
    margin-bottom: 15px;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    transition: all 0.3s;
    cursor: pointer;
}
.single-classes-item:hover .article-desc {
    -webkit-line-clamp: unset;
    max-height: 500px;
    white-space: normal;
    overflow: visible;
    background: #fff;
    z-index: 2;
    position: relative;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}
</style>

<script>
let sortOrder = 'desc';
const sortBtn = document.getElementById('sort-btn');
const sortIcon = document.getElementById('sort-icon');
const articlesRow = document.getElementById('articles-row');
const searchInput = document.getElementById('search-input');

sortBtn.addEventListener('click', function(e) {
    e.preventDefault();
    const items = Array.from(articlesRow.getElementsByClassName('article-item'));
    items.sort((a, b) => {
        const dateA = a.getAttribute('data-date');
        const dateB = b.getAttribute('data-date');
        if (sortOrder === 'asc') {
            return dateA.localeCompare(dateB);
        } else {
            return dateB.localeCompare(dateA);
        }
    });
    // Remove all items
    while (articlesRow.firstChild) {
        articlesRow.removeChild(articlesRow.firstChild);
    }
    // Append sorted items
    items.forEach(item => articlesRow.appendChild(item));
    // Toggle sort order and icon
    if (sortOrder === 'desc') {
        sortOrder = 'asc';
        sortIcon.className = 'fa-solid fa-arrow-up';
        sortBtn.innerHTML = '<i id="sort-icon" class="fa-solid fa-arrow-up"></i> Sort by Date (Oldest First)';
    } else {
        sortOrder = 'desc';
        sortIcon.className = 'fa-solid fa-arrow-down';
        sortBtn.innerHTML = '<i id="sort-icon" class="fa-solid fa-arrow-down"></i> Sort by Date (Latest First)';
    }
});

// Real-time search filter
searchInput.addEventListener('input', function() {
    const query = searchInput.value.toLowerCase();
    const items = articlesRow.getElementsByClassName('article-item');
    Array.from(items).forEach(item => {
        const title = item.querySelector('.classes-text h4 a').textContent.toLowerCase();
        const desc = item.querySelector('.article-desc').textContent.toLowerCase();
        if (title.includes(query) || desc.includes(query)) {
            item.style.display = '';
        } else {
            item.style.display = 'none';
        }
    });
});
</script>

<jsp:include page="footer.jsp" />