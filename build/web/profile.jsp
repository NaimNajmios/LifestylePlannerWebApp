<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,java.io.*" %>
<%
    String gender = "";
    String weight = "";
    String height = "";
    try {
        String filePath = application.getRealPath("/") + "user_profile.xml";
        File xmlFile = new File(filePath);
        if (xmlFile.exists()) {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(xmlFile);
            doc.getDocumentElement().normalize();
            gender = doc.getElementsByTagName("gender").item(0).getTextContent();
            weight = doc.getElementsByTagName("weight").item(0).getTextContent();
            height = doc.getElementsByTagName("height").item(0).getTextContent();
        }
    } catch (Exception e) {
        // ignore, just don't display
    }
%>
<jsp:include page="header.jsp" />
<section class="main-content" style="margin: 50px 0;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <% if (!gender.isEmpty() && !weight.isEmpty() && !height.isEmpty()) { %>
                <div class="card shadow mb-4 mx-auto">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0"><i class="fa-solid fa-id-card"></i> Current Profile</h3>
                    </div>
                    <div class="card-body p-3">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <span><i class="fa-solid fa-venus-mars"></i> Gender</span>
                                <span class="fw-bold"><%= gender %></span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <span><i class="fa-solid fa-weight-scale"></i> Weight</span>
                                <span class="fw-bold"><%= weight %> kg</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <span><i class="fa-solid fa-ruler-vertical"></i> Height</span>
                                <span class="fw-bold"><%= height %> cm</span>
                            </li>
                        </ul>
                    </div>
                </div>
                <% } %>
                <div class="card shadow mb-4">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0"><i class="fa-solid fa-user"></i> Profile Information</h3>
                    </div>
                    <div class="card-body">
                        <form action="SaveProfileServlet" method="post">
                            <div class="form-group mb-3">
                                <label for="gender"><i class="fa-solid fa-venus-mars"></i> Gender:</label>
                                <select name="gender" id="gender" class="form-control" required>
                                    <option value="" disabled <%= gender.isEmpty() ? "selected" : "" %>>Select gender</option>
                                    <option value="male" <%= "male".equalsIgnoreCase(gender) ? "selected" : "" %>>Male</option>
                                    <option value="female" <%= "female".equalsIgnoreCase(gender) ? "selected" : "" %>>Female</option>
                                </select>
                            </div>
                            <div class="form-group mb-3">
                                <label for="weight"><i class="fa-solid fa-weight-scale"></i> Weight (kg):</label>
                                <input type="number" name="weight" id="weight" class="form-control" placeholder="e.g. 70.5" required value="<%= weight %>">
                            </div>
                            <div class="form-group mb-4">
                                <label for="height"><i class="fa-solid fa-ruler-vertical"></i> Height (cm):</label>
                                <input type="number" name="height" id="height" class="form-control" placeholder="e.g. 175.0" required value="<%= height %>">
                            </div>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fa-solid fa-save"></i> Save Profile
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp" /> 