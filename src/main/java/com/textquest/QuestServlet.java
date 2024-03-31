package com.textquest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "QuestServlet", value = "/quest")
public class QuestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        if (session.getAttribute("visited") == null) {
            session.setAttribute("visited", true);
            session.setAttribute("victory", false);
            session.setAttribute("defeat", false);
            session.setAttribute("stage", Stage.FIRST);
            session.setAttribute("IP_address", req.getRemoteAddr());
        }

        getServletContext().getRequestDispatcher("/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String action = req.getParameter("action");

        switch (action) {
            case "positiveAnswer1":
                session.setAttribute("stage", Stage.SECOND);
                break;
            case "negativeAnswer1":
                session.setAttribute("stage", Stage.SECOND);
                session.setAttribute("defeat", true);
                break;
            case "positiveAnswer2":
                session.setAttribute("stage", Stage.THIRD);
                break;
            case "negativeAnswer2":
                session.setAttribute("stage", Stage.THIRD);
                session.setAttribute("defeat", true);
                break;
            case "positiveAnswer3":
                session.setAttribute("stage", Stage.FOURTH);
                session.setAttribute("victory", true);
                break;
            case "negativeAnswer3":
                session.setAttribute("stage", Stage.FOURTH);
                session.setAttribute("defeat", true);
                break;
        }

        resp.sendRedirect("quest");
    }
}
