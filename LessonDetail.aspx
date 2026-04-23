<%@ Page Title="Lesson Detail | GST Champions" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="LessonDetail.aspx.cs" Inherits="LessonDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-secondary: #a855f7; 
            --brand-dark: #0f172a;
            --bg-soft: #f8fafc;
        }

        body { background-color: var(--bg-soft); }

        /* --- Refined Breadcrumb --- */
        .breadcrumb-wrap { background: transparent; padding: 25px 0 10px; }
        .breadcrumb-item a { color: var(--brand-primary); font-weight: 700; text-decoration: none; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; }
        .breadcrumb-item.active { color: #94a3b8; font-weight: 700; font-size: 0.8rem; text-transform: uppercase; }

        /* --- Master Layout --- */
        .lesson-split-container { display: flex; flex-wrap: wrap; gap: 50px; margin-top: 20px; padding-bottom: 100px; align-items: flex-start; }

        /* Left Side: Premium Floating Sidebar */
        .lesson-info-sidebar { 
            flex: 0 0 380px; 
            position: sticky; 
            top: 110px; 
            background: linear-gradient(135deg, var(--brand-dark) 0%, #1e1b4b 100%);
            color: white; 
            padding: 45px 35px; 
            border-radius: 40px; 
            box-shadow: 0 40px 80px rgba(15, 23, 42, 0.25);
            overflow: hidden;
        }

        .lesson-info-sidebar::before {
            content: '';
            position: absolute;
            top: -50px; right: -50px; width: 150px; height: 150px;
            background: radial-gradient(circle, rgba(168, 85, 247, 0.2) 0%, transparent 70%);
        }

        .back-link { 
            display: inline-flex;
            align-items: center;
            color: rgba(255,255,255,0.5); 
            text-decoration: none; 
            font-weight: 800; 
            font-size: 0.75rem; 
            text-transform: uppercase; 
            letter-spacing: 1.5px;
            transition: 0.3s;
            margin-bottom: 30px;
        }
        .back-link:hover { color: var(--brand-secondary); transform: translateX(-5px); }

        .lesson-title { font-size: 2.5rem; font-weight: 900; line-height: 1.1; letter-spacing: -2px; margin-bottom: 25px; }

        .meta-group { display: flex; flex-direction: column; gap: 12px; }
        .meta-pill-dark { 
            background: rgba(255,255,255,0.05); 
            border: 1px solid rgba(255,255,255,0.1);
            padding: 10px 18px; 
            border-radius: 15px; 
            font-size: 0.85rem; 
            font-weight: 600;
            display: flex;
            align-items: center;
            width: fit-content;
        }

        /* Right Side: Reading Area */
        .lesson-content-main { 
            flex: 1; 
            min-width: 320px; 
            background: white; 
            padding: 60px; 
            border-radius: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.02);
            border: 1px solid rgba(0,0,0,0.03);
        }

        .article-content { font-size: 1.25rem; line-height: 2; color: #334155; }
        
        /* Modern Typography within Content */
        .article-content h2 { 
            font-size: 2rem;
            color: var(--brand-dark); 
            font-weight: 900; 
            margin-top: 60px; 
            margin-bottom: 25px;
            display: flex;
            align-items: center;
        }
        .article-content h2::before {
            content: '';
            width: 8px; height: 35px;
            background: var(--brand-primary);
            margin-right: 15px;
            border-radius: 4px;
        }

        .article-content p { margin-bottom: 35px; }
        
        .article-content img { 
            width: 100%; 
            border-radius: 30px; 
            margin: 40px 0; 
            box-shadow: 0 30px 60px rgba(0,0,0,0.1); 
        }

        /* --- Enhanced Progress --- */
        .reading-progress-container { margin-top: 50px; }
        .progress-label { font-size: 0.7rem; font-weight: 800; text-transform: uppercase; color: rgba(255,255,255,0.4); letter-spacing: 1px; }
        .custom-progress { background: rgba(255,255,255,0.1); height: 8px; border-radius: 10px; margin-top: 10px; overflow: hidden; }
        .custom-progress-bar { background: linear-gradient(to right, var(--brand-primary), var(--brand-secondary)); height: 100%; width: 0%; transition: 0.4s; }

        /* --- Premium CTA --- */
        .quiz-cta-box { 
            background: var(--brand-dark); 
            background-image: url('https://www.transparenttextures.com/patterns/cubes.png');
            color: white; 
            padding: 50px; 
            border-radius: 35px; 
            margin-top: 80px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }

        .btn-start-quiz {
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            color: white !important;
            font-weight: 900;
            border-radius: 18px;
            padding: 18px 40px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
            transition: 0.3s;
            border: none;
            z-index: 2;
        }
        .btn-start-quiz:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(99, 102, 241, 0.4); }

        .fw-900 { font-weight: 900 !important; }

        @media (max-width: 992px) {
            .lesson-info-sidebar { position: relative; top: 0; flex: 0 0 100%; border-radius: 30px; }
            .lesson-content-main { padding: 30px; border-radius: 30px; }
            .lesson-split-container { gap: 30px; }
            .quiz-cta-box { flex-direction: column; text-align: center; gap: 30px; padding: 40px 20px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="breadcrumb-wrap animate__animated animate__fadeIn">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="index.aspx">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page"> Content</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="container">
        <div class="lesson-split-container">
            
            <aside class="lesson-info-sidebar animate__animated animate__fadeInLeft">
                <a href="javascript:history.back()" class="back-link">
                    <i class="fas fa-chevron-left me-2"></i> Previous Page
                </a>
                
                <h1 class="lesson-title"><asp:Literal ID="litTitle" runat="server"></asp:Literal></h1>
                
                <div class="meta-group mt-4">
                    <div class="meta-pill-dark">
                        <i class="far fa-calendar-check me-3 text-info"></i>
                        <span>Updated: <asp:Literal ID="litDate" runat="server"></asp:Literal></span>
                    </div>
                    <div class="meta-pill-dark">
    <i class="fas fa-graduation-cap me-3 text-secondary"></i>
    <span>Level: <asp:Literal ID="litLevel" runat="server"></asp:Literal></span>
</div>
                  
                </div>

                <div class="reading-progress-container d-none d-lg-block">
                    <span class="progress-label">Scroll Progress</span>
                    <div class="custom-progress">
                        <div id="readingProgress" class="custom-progress-bar"></div>
                    </div>
                </div>
                
                <div class="mt-5 p-4 rounded-4" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.05);">
                    <p class="small text-white opacity-50 mb-0">Need help with this topic? Use our 24/7 expert chat available in the dashboard.</p>
                </div>
                <div class="mt-5 p-4 rounded-4" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.05);">
    <p class="small text-white opacity-50 mb-3">Need help with this topic? Use our expert assistance.</p>
    <a href='Contact.aspx?Subject=Inquiry: <%= litTitle.Text %>' class="btn btn-outline-light btn-sm rounded-pill px-4">
        <i class="fas fa-envelope me-2"></i> Contact Expert
    </a>
</div>
            </aside>

            <main class="lesson-content-main animate__animated animate__fadeInUp">
                <div class="mb-5 d-flex justify-content-between align-items-center">
                    <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill fw-bold">GST CHAMPIONS EXCLUSIVE</span>
                   <%-- <div class="d-flex gap-2">
                        <button type="button" class="btn btn-light btn-sm rounded-circle"><i class="fas fa-print"></i></button>
                        <button type="button" class="btn btn-light btn-sm rounded-circle"><i class="fas fa-share-alt"></i></button>
                    </div>--%>
                </div>

                <article class="article-content" id="lessonBody">
                    <asp:Literal ID="litContent" runat="server"></asp:Literal>
                </article>

                <div class="quiz-cta-box shadow-lg animate__animated animate__zoomIn">
                    <div class="position-relative" style="z-index:2">
                        <h2 class="fw-900 mb-2 text-white">Mastered this topic?</h2>
                        <p class="mb-0 opacity-75 fs-5">Put your knowledge to the test and earn your badge.</p>
                    </div>
                   <a href='Quiz.aspx?TopicID=<%= Request.QueryString["TopicID"] %>' class="btn btn-start-quiz">
    Launch Topic Quiz <i class="fas fa-rocket ms-2"></i>
</a>
                </div>
                
                <div class="text-center mt-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/190/190411.png" width="40" class="opacity-25 mb-3" />
                    <p class="text-muted small fw-bold">Verified Educational Resource • 2026 Edition</p>
                </div>
            </main>

        </div>
    </div>

    <script>
        window.onscroll = function () {
            var winScroll = document.body.scrollTop || document.documentElement.scrollTop;
            var height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
            var scrolled = (winScroll / height) * 100;
            document.getElementById("readingProgress").style.width = scrolled + "%";
        };
    </script>
</asp:Content>