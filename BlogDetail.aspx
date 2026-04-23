<%@ Page Title="Blog Detail | GST Champions" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="BlogDetail.aspx.cs" Inherits="BlogDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-dark: #0f172a;
            --bg-muted: #f1f5f9;
        }

        .article-container { padding: 40px 0 80px; background: #fff; }

        /* --- Main Layout Grid --- */
        .blog-detail-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 50px;
            align-items: flex-start;
        }

        /* --- Left Side: Visuals --- */
        .visual-sidebar {
            flex: 0 0 420px;
            position: sticky;
            top: 100px;
        }

      
        .hero-img {
            max-width: 100%;
            max-height: 100%;
            width: auto;
            height: auto;
            object-fit: contain; /* Sabse important: Isse image puri dikhegi, kategi nahi */
            display: block;
        }

        /* --- Right Side: Content --- */
        .content-main {
            flex: 1;
            min-width: 300px;
        }

        .article-title {
            font-size: 2.8rem;
            font-weight: 900;
            color: var(--brand-dark);
            line-height: 1.1;
            margin: 10px 0 20px;
            letter-spacing: -1px;
        }

        .meta-info {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            color: #64748b;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .article-text {
            font-size: 1.15rem;
            line-height: 1.8;
            color: #334155;
        }

        .nav-link-back {
            display: inline-flex;
            align-items: center;
            color: var(--brand-primary);
            text-decoration: none;
            font-weight: 800;
            text-transform: uppercase;
            font-size: 0.8rem;
            margin-bottom: 25px;
            transition: 0.3s;
        }
        .nav-link-back:hover { transform: translateX(-5px); }

        @media (max-width: 991px) {
            .visual-sidebar { flex: 0 0 100%; position: relative; top: 0; }
            .img-holder { height: auto; padding: 20px; }
            .article-title { font-size: 2rem; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="article-container">
        <div class="container">
            
            <a href="KnowledgeHub.aspx" class="nav-link-back">
                <i class="fas fa-arrow-left me-2"></i> Back to Hub
            </a>

            <div class="blog-detail-grid">
                
                <div class="visual-sidebar animate__animated animate__fadeIn">
                    <div class="img-holder">
                        <asp:Image ID="imgBlog" runat="server" CssClass="hero-img" AlternateText="Full GST Image" />
                    </div>
                    
                    <div class="mt-4 p-4 bg-light rounded-4 border-start border-primary border-4 shadow-sm">
                        <h6 class="fw-bold text-dark mb-2">Key Highlight</h6>
                        <p class="small text-muted mb-0">Accuracy aur compliance humari priority hai. Har update ko dhyan se follow karein.</p>
                    </div>
                </div>

                <div class="content-main">
                    <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill mb-3 fw-bold">GST INSIGHTS</span>
                    <h1 class="article-title">
                        <asp:Literal ID="litTitle" runat="server"></asp:Literal>
                    </h1>

                    <div class="meta-info">
                        <span><i class="far fa-calendar-alt me-1"></i> <asp:Literal ID="litDate" runat="server"></asp:Literal></span>
                        <span>|</span>
                        <span><i class="far fa-user me-1"></i> Admin</span>
                    </div>

                    <div class="article-text">
                        <asp:Literal ID="litContent" runat="server"></asp:Literal>
                    </div>

                    <div class="share-section mt-5 pt-4 border-top">
                        <div class="d-flex align-items-center gap-3">
                            <span class="fw-bold small text-muted">SHARE:</span>
                            <a href="#" class="btn btn-outline-primary btn-sm rounded-circle"><i class="fab fa-whatsapp"></i></a>
                            <a href="#" class="btn btn-outline-primary btn-sm rounded-circle"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>