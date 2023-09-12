<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="content">
    <div class="error-page">
        <h2 class="headline text-warning">ACCESS ERROR</h2>
        <div class="error-content">
            <h3>
                <i class="fas fa-exclamation-triangle text-warning"></i> Oops! ${message}
            </h3>
            <p>
                ${SPRING_SECURITY_403_EXCEPTION.getMessage()}
                Meanwhile, you may
                <a href="/">return to dashboard</a> or try using the
                search form.
            </p>
        </div>

    </div>

</section>

