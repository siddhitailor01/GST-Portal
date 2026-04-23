<%@ Page Title="My Quiz Performance | GST Champions" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="QuizResult.aspx.cs" Inherits="QuizResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <meta name="robots" content="noindex, nofollow" />
     <meta name="description" content="Check your GST proficiency score and detailed question review on GST Champions. Analyze your errors and master taxation rules." />
    
    <meta property="og:title" content="I just completed the GST Mastery Quiz!" />
    <meta property="og:description" content="Check out my performance and test your own GST knowledge on Rajasthan's top learning portal." />
    <meta property="og:image" content="https://www.gstchampions.in/images/quiz-result-share.jpg" />

    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-secondary: #a855f7; 
            --brand-dark: #0f172a;
            --brand-success: #10b981;
            --brand-danger: #ef4444;
        }

        .result-container { background: #f8fafc; padding: 30px 0; }

        /* --- Master Layout: Side-by-Side Dashboard --- */
        .dashboard-grid { display: flex; flex-wrap: wrap; gap: 25px; align-items: flex-start; }
        
        /* Sidebar: Sticky Score Summary */
        .sidebar-score { flex: 0 0 360px; position: sticky; top: 90px; }
        
        /* Main Content: Scrollable Review */
        .review-area { flex: 1; min-width: 450px; }

        /* --- Compact Sidebar Card --- */
        .score-card-main {
            background: white; border-radius: 30px; padding: 35px 25px;
            box-shadow: 0 15px 40px rgba(15, 23, 42, 0.08);
            border: 1px solid rgba(0,0,0,0.02);
            text-align: center; overflow: hidden;
        }

        .score-circle {
            width: 150px; height: 150px; border-radius: 50%;
            background: conic-gradient(var(--brand-primary) calc(var(--percentage) * 1%), #f1f5f9 0);
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px; position: relative;
        }
        .score-circle::before { content: ""; position: absolute; width: 125px; height: 125px; background: white; border-radius: 50%; }
        .score-inner { position: relative; z-index: 1; }
        .score-text { font-size: 2.5rem; font-weight: 900; color: var(--brand-dark); margin: 0; }

        /* Compact Stats Pills */
        .stat-mini { background: #f8fafc; border-radius: 15px; padding: 12px; margin-bottom: 8px; border: 1px solid #edf2f7; text-align: left; display: flex; justify-content: space-between; align-items: center; }
        .stat-mini h4 { margin: 0; font-size: 1.1rem; font-weight: 900; }
        .stat-mini.correct { color: var(--brand-success); }
        .stat-mini.wrong { color: var(--brand-danger); }

        /* --- Efficient Review Cards --- */
        .detail-card { 
            border: 1px solid rgba(0,0,0,0.03); border-radius: 25px; 
            margin-bottom: 20px; background: white;
            border-left: 6px solid var(--brand-danger) !important;
            box-shadow: 0 4px 12px rgba(0,0,0,0.02);
        }

        /* 2-Column Result Layout per Question */
        .result-split-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }

        .explanation-box { 
            background: #f8fafc; border-radius: 15px; border: 1px solid #edf2f7; padding: 15px !important; margin-top: 15px;
        }

        .badge-premium { background: var(--brand-dark); color: white; padding: 6px 15px; border-radius: 50px; font-weight: 800; font-size: 0.7rem; text-transform: uppercase; margin-bottom: 15px; display: inline-block; }
        .btn-premium { padding: 12px 25px; border-radius: 12px; font-weight: 900; text-transform: uppercase; font-size: 0.8rem; width: 100%; transition: 0.3s; }
        .fw-900 { font-weight: 900 !important; }

        @media (max-width: 991px) {
            .sidebar-score { flex: 0 0 100%; position: relative; top: 0; }
            .review-area { min-width: 100%; }
            .result-split-grid { grid-template-columns: 1fr; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="result-container">
        <div class="container">
            <div class="dashboard-grid">
                
                <aside class="sidebar-score animate__animated animate__fadeInLeft">
                    <div class="score-card-main">
                        <div class="badge-premium">
                            <i class="fas fa-certificate text-warning me-2"></i> <asp:Label ID="lblTitle" runat="server"></asp:Label>
                        </div>
                        
                        <div class="score-circle" id="divCircle" runat="server">
                            <div class="score-inner">
                                <p class="score-text"><asp:Label ID="lblScore" runat="server"></asp:Label></p>
                                <small class="text-muted fw-900 uppercase" style="font-size:0.6rem">Points</small>
                            </div>
                        </div>

                        <h5 class="fw-900 text-dark mb-4"><asp:Label ID="lblStatus" runat="server"></asp:Label></h5>

                        <div class="stats-mini-wrap mb-4">
                            <div class="stat-mini">
                                <small class="fw-900 opacity-50 uppercase">Total Items</small>
                                <h4><asp:Label ID="lblTotalQ" runat="server"></asp:Label></h4>
                            </div>
                            <div class="stat-mini correct">
                                <small class="fw-900 opacity-70 uppercase">Correct</small>
                                <h4><asp:Label ID="lblCorrectCount" runat="server"></asp:Label></h4>
                            </div>
                            <div class="stat-mini wrong">
                                <small class="fw-900 opacity-70 uppercase">Errors</small>
                                <h4><asp:Label ID="lblWrongCount" runat="server"></asp:Label></h4>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <a href="Quiz.aspx" class="btn btn-primary btn-premium shadow-sm">Retake</a>
                            <asp:HyperLink ID="hlWhatsApp" runat="server" target="_blank" CssClass="btn btn-success btn-premium">
                                <i class="fab fa-whatsapp me-2"></i> Share
                            </asp:HyperLink>
                        </div>

                    <%--    <div class="mt-4 p-3 bg-light rounded-3 text-start border-start border-primary border-4">
                            <span class="fw-900 text-primary uppercase" style="font-size:0.65rem">Expert Take:</span>
                            <p class="mb-0 text-dark fw-bold small italic">"<asp:Literal ID="litRoast" runat="server"></asp:Literal>"</p>
                        </div>--%>
                    </div>
                </aside>

     <main class="review-area">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-900 mb-0 text-dark">
            <i class="fas fa-chart-line text-primary me-3"></i> <asp:Literal ID="litReviewTitle" runat="server"></asp:Literal>
        </h5>
        <button type="button" id="btnToggleReview" class="btn btn-outline-primary btn-sm rounded-pill fw-bold px-4" onclick="toggleMistakes()" style="display:none;">
            Review Mistakes
        </button>
    </div>

    <div id="insightWidgets" class="animate__animated animate__fadeIn">
        <div class="row g-4">
            <div class="col-md-6">
                <div class="card p-4 border-0 shadow-sm rounded-4 h-100" style="background: #eef2ff;">
                    <h6 class="fw-900 text-indigo-600 mb-3"><i class="fas fa-bullseye me-2"></i>Accuracy Level</h6>
                    <div class="display-5 fw-900 text-dark mb-2"><asp:Literal ID="litPercentage" runat="server"></asp:Literal>%</div>
                    <p class="small text-muted mb-0">Aapka precision score aapke expert level ko darshata hai.</p>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card p-4 border-0 shadow-sm rounded-4 h-100" style="background: #fff7ed;">
                    <h6 class="fw-900 text-orange-600 mb-3"><i class="fas fa-comment-dots me-2"></i>Expert Take</h6>
                    <p class="text-muted fw-bold small italic mb-0">
                        "<asp:Literal ID="litRoastInsight" runat="server"></asp:Literal>"
                    </p>
                </div>
            </div>

            <div class="col-12">
                <div class="card p-5 border-0 shadow-sm rounded-4 text-center bg-white border-start border-primary border-5">
                    <i class="fas fa-graduation-cap fa-3x text-primary opacity-25 mb-3"></i>
                    <h5 class="fw-900">What's Next for You?</h5>
                    <p class="text-muted">Aapne accha perform kiya! Agle level par jaane ke liye aur practice karein ya hamare blog updates padhein.</p>
                    <div class="d-flex justify-content-center gap-3 mt-3">
                        <a href="Level1.aspx" class="btn btn-light rounded-pill px-4 fw-bold">Learn More</a>
                        <a href="KnowledgeHub.aspx" class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm">Visit Blog</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

           <div id="mistakeSection" style="display: none;" class="animate__animated animate__fadeInUp">
        <asp:Repeater ID="rptDetails" runat="server">
            <ItemTemplate>
                <div class="card detail-card shadow-sm mb-4">
                    <div class="card-body p-4">
                        <h6 class="fw-900 mb-3 text-dark">Q: <%# Eval("QuestionText") %></h6>
                        <div class="result-split-grid">
                            <div class="p-3 border rounded-3 bg-light">
                                <p class="mb-1 text-muted small fw-900 uppercase" style="font-size:0.6rem">Your Choice</p>
                                <p class="fw-bold text-danger mb-0 small"><i class="fas fa-times me-1"></i><%# GetOptionText(Eval("UserAnswer"), Container.DataItem) %></p>
                            </div>
                            <div class="p-3 border border-success-subtle bg-success-subtle rounded-3">
                                <p class="mb-1 text-success small fw-900 uppercase" style="font-size:0.6rem">Correct Solution</p>
                                <p class="fw-bold text-success mb-0 small"><i class="fas fa-check me-1"></i><%# GetOptionText(Eval("CorrectOption"), Container.DataItem) %></p>
                            </div>
                        </div>
                        <div class="explanation-box mt-3">
                            <p class="mb-0 text-secondary small lh-base"><i class="fas fa-info-circle me-1"></i> <%# Eval("Explanation") %></p>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    </main>

<script>
    function toggleMistakes() {
        var mistakeSec = document.getElementById('mistakeSection');
        var insightSec = document.getElementById('insightWidgets');
        var btn = document.getElementById('btnToggleReview');
        
        if (mistakeSec.style.display === "none") {
            mistakeSec.style.display = "block";
            insightSec.style.display = "none";
            btn.innerText = "Back to Insights";
            btn.className = "btn btn-dark btn-sm rounded-pill fw-bold px-4";
        } else {
            mistakeSec.style.display = "none";
            insightSec.style.display = "block";
            btn.innerText = "Review Mistakes";
            btn.className = "btn btn-outline-primary btn-sm rounded-pill fw-bold px-4";
        }
    }

    window.onload = function() {
        var hasMistakes = <%= (rptDetails.Items.Count > 0) ? "true" : "false" %>;
        if(hasMistakes) {
            document.getElementById('btnToggleReview').style.display = "block";
        }
    }
</script>

            </div>
        </div>
    </div>
</asp:Content>