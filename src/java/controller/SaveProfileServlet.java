package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;

public class SaveProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String gender = request.getParameter("gender");
        String weight = request.getParameter("weight");
        String height = request.getParameter("height");

        try {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.newDocument();

            Element rootElement = doc.createElement("profile");
            doc.appendChild(rootElement);

            Element genderElem = doc.createElement("gender");
            genderElem.appendChild(doc.createTextNode(gender));
            rootElement.appendChild(genderElem);

            Element weightElem = doc.createElement("weight");
            weightElem.appendChild(doc.createTextNode(weight));
            rootElement.appendChild(weightElem);

            Element heightElem = doc.createElement("height");
            heightElem.appendChild(doc.createTextNode(height));
            rootElement.appendChild(heightElem);

            // Save XML to file (e.g., in webapp root)
            String filePath = getServletContext().getRealPath("/") + "user_profile.xml";
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File(filePath));
            transformer.transform(source, result);

            response.sendRedirect("exercise.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving profile.");
        }
    }
} 