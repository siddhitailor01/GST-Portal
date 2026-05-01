<%@ Page Title="GST Champions | Best GST Learning Portal in Bhilwara, Rajasthan" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="description" content="Learn GST from basics to expert level with GST Champions. Rajasthan's leading education hub for tax professionals, commerce students, and accountants in Bhilwara." />
    <meta name="keywords" content="GST Learning Rajasthan, Tax Classes Bhilwara, GST Practitioners Course, Online GST Training India, HSN Finder Tool" />
    <link rel="canonical" href="https://www.gstchampions.in/index.aspx" />

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "FAQPage",
      "mainEntity": [{
        "@type": "Question",
        "name": "What is GST Champions?",
        "acceptedAnswer": {
          "@type": "Answer",
          "text": "GST Champions is Rajasthan's premier learning portal designed to simplify complex taxation for students and professionals."
        }
      },
      {
        "@type": "Question",
        "name": "Where is GST Champions located?",
        "acceptedAnswer": {
          "@type": "Answer",
          "text": "We are headquartered in Bhilwara, Rajasthan, serving students across India."
        }
      }]
    }
    </script>
    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-secondary: #a855f7; 
            --brand-dark: #0f172a;
            --brand-accent: #f43f5e;
            --text-main: #1e293b;
        }


        /* --- Hero Section: High Impact --- */
        .hero-section { 
            background: radial-gradient(circle at top left, rgba(99, 102, 241, 0.12), transparent 40%),
                        radial-gradient(circle at bottom right, rgba(168, 85, 247, 0.08), transparent 40%);
            padding: 160px 0 120px; 
            overflow: hidden;
        }

        .hero-title { 
            font-size: 4.8rem; 
            font-weight: 900 !important; 
            color: var(--brand-dark); 
            line-height: 1; 
            letter-spacing: -3px;
        }

        .hero-title span {
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* --- Stats Card: Glassmorphism --- */
        .stats-wrap { 
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.98), rgba(30, 41, 59, 0.98));
            backdrop-filter: blur(15px);
            color: white; 
            padding: 50px; 
            border-radius: 40px; 
            margin-top: -90px; 
            z-index: 10; 
            position: relative;
            box-shadow: 0 40px 100px rgba(0,0,0,0.25);
            border: 1px solid rgba(255,255,255,0.1);
        }

        .fw-900 { font-weight: 900 !important; }

        /* --- Level Journey Cards --- */
        .level-card { 
            border: 1px solid rgba(0,0,0,0.04); 
            border-radius: 40px; 
            padding: 60px 45px; 
            transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1); 
            background: white; 
            height: 100%; 
            position: relative; 
            z-index: 1;
            box-shadow: 0 10px 30px rgba(0,0,0,0.02);
        }

        .level-card:hover { 
            transform: translateY(-20px); 
            border-color: var(--brand-primary);
            box-shadow: 0 40px 80px rgba(99, 102, 241, 0.12);
        }

        .icon-circle {
            width: 80px; height: 80px;
            background: #f1f5f9;
            border-radius: 24px;
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem; margin-bottom: 30px;
            transition: 0.5s;
        }

        .level-card:hover .icon-circle {
            background: var(--brand-primary);
            color: white !important;
            transform: rotate(-10deg) scale(1.1);
        }

        /* --- Modern Content Sections --- */
        .about-home { padding: 140px 0; }
        .about-img { border-radius: 50px; box-shadow: 0 50px 100px rgba(0,0,0,0.1); }

       /* --- Blog Image Container Fix --- */
    .blog-img-box {
        /*height: 220px; /* Card ki ek standard height */
        background: #f8fafc; /* Light gray background agar image choti ho */
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        border-radius: 28px 28px 0 0; /* Card ke upar ke corners */
        border-bottom: 1px solid #f1f5f9;
    }

    .card-img-top-fixed {
        max-width: 100%;
        max-height: 100%;
        width: auto;
        height: auto;
        object-fit: contain; /* Isse image kategi nahi, poori dikhegi */
        transition: 0.5s;
    }

    .preview-card:hover .card-img-top-fixed {
        transform: scale(1.05); /* Hover par halka sa zoom */
    }

        /* --- Custom FAQ: Dashboard Style --- */
        .custom-faq .accordion-item { border: none; margin-bottom: 20px; border-radius: 25px !important; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        .custom-faq .accordion-button { 
            padding: 25px; font-weight: 800; background: white; border-radius: 25px !important;
            color: var(--brand-dark); transition: 0.3s; 
        }
        .custom-faq .accordion-button:not(.collapsed) { 
            color: var(--brand-primary); background: #f5f3ff;
        }
        
        /* Masonry layout logic for FAQ */
.custom-faq .row {
    display: block; /* Row ko block kiya taaki columns float kar sakein */
    column-count: 2; /* Content ko 2 columns mein divide karega */
    column-gap: 24px;
}

.custom-faq .col-md-6 {
    display: inline-block; /* Element ko container ke andar wrap karega */
    width: 100%; /* Column width handle karne ke liye */
    margin-bottom: 24px;
    float: none;
}

/* Accordion Open State fixes */
.custom-faq .accordion-collapse {
    transition: all 0.4s ease-in-out;
}

/* Responsiveness for Mobile */
@media (max-width: 768px) {
    .custom-faq .row {
        column-count: 1; /* Mobile par wapas single column */
    }
}
        .floating-img { animation: floating 4s ease-in-out infinite; }
        @keyframes floating { 
            0%, 100% { transform: translateY(0px) rotate(0deg); } 
            50% { transform: translateY(-25px) rotate(2deg); } 
        }

        .btn-quiz {
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            color: white !important; font-weight: 800; border: none; border-radius: 18px;
            padding: 18px 45px; transition: 0.3s;
        }
        .btn-quiz:hover { transform: translateY(-5px); box-shadow: 0 20px 40px rgba(99, 102, 241, 0.4); }

          .blog-card { 
            border: 1px solid rgba(0,0,0,0.05); 
            border-radius: 28px; 
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); 
            overflow: hidden; 
            height: 100%; 
            background: #fff; 
            display: flex;
            flex-direction: column;
        }

        .blog-card:hover { 
            transform: translateY(-12px); 
            box-shadow: 0 30px 60px rgba(15, 23, 42, 0.12); 
            border-color: var(--brand-primary);
        }

        /* --- Image Fixing Logic --- */
        .blog-img-container {
            position: relative;
            /*height: 220px; /* Fixed viewport height */
            background: #f8fafc; /* Light gray base for mismatched images */
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-bottom: 1px solid #f1f5f9;
        }

        .blog-img { 
            max-width: 100%;
            max-height: 100%;
            width: auto;
            height: auto;
            object-fit: contain; /* Ensures the FULL image is shown without cutting */
            transition: 0.5s;
        }

        .blog-card:hover .blog-img {
            transform: scale(1.05);
        }

        /* --- UI Elements --- */
        .date-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(8px);
            color: var(--brand-dark);
            padding: 5px 12px;
            border-radius: 10px;
            font-size: 0.7rem;
            font-weight: 800;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }


        .card-body { padding: 25px; flex-grow: 1; display: flex; flex-direction: column; }
        
        .card-title { 
            font-size: 1.25rem; 
            font-weight: 900 !important;
            color: var(--brand-dark); 
            margin-bottom: 12px;
            line-height: 1.3;
        }

        .short-desc {
            color: #64748b;
            font-size: 0.9rem;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .continue-btn {
            font-weight: 800;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--brand-primary);
            text-decoration: none;
            margin-top: auto;
            display: inline-flex;
            align-items: center;
        }

        .continue-btn i { transition: 0.3s; margin-left: 8px; }
        .blog-card:hover .continue-btn i { transform: translateX(5px); }

        .hr-soft { opacity: 0.05; margin: 15px 0; }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-7">
                    <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill mb-4 fw-bold shadow-sm">
                        <i class="fas fa-crown me-2 text-warning"></i> BHILWARA'S #1 TAX EDUCATION HUB
                    </span>
                    <h1 class="hero-title">Master the <br />Art of <span>GST</span></h1>
                    <p class="fs-5 text-secondary my-5 pe-lg-5" style="line-height: 1.9;">
                        Taxation ki complexity ko ab bolo bye-bye . Humare level-based framework aur practical case studies ke saath baniye ek certified tax expert.
                    </p>
                    <div class="d-flex flex-wrap gap-3">
                        <a href="Level1.aspx" class="btn btn-quiz shadow-lg">Start Learning <i class="fas fa-bolt ms-2"></i></a>
                        <a href="Quiz.aspx" class="btn btn-outline-dark border-2 px-5 py-3 rounded-4 fw-900">Practice Quiz</a>
                    </div>
                </div>
                <div class="col-lg-5 d-none d-lg-block">
                    <img src="https://illustrations.popsy.co/violet/creative-work.svg" alt="GST Learning" class="img-fluid floating-img">
                </div>
            </div>
        </div>
    </section>

    <div class="container mt-5">
        <div class="stats-wrap">
            <div class="row g-4">
                <div class="col-md-4 text-center">
                    <h2 class="display-5 fw-900 mb-1"><asp:Literal ID="litTopicCount" runat="server">15</asp:Literal>+</h2>
                    <p class="small text-uppercase tracking-widest opacity-50 fw-bold">Detailed Modules</p>
                </div>
                <div class="col-md-4 text-center border-md-start border-white border-opacity-10">
                    <h2 class="display-5 fw-900 mb-1"><asp:Literal ID="litQuestionCount" runat="server">150</asp:Literal>+</h2>
                    <p class="small text-uppercase tracking-widest opacity-50 fw-bold">Simulation Questions</p>
                </div>
                <div class="col-md-4 text-center border-md-start border-white border-opacity-10">
                    <h2 class="display-5 fw-900 mb-1">100%</h2>
                    <p class="small text-uppercase tracking-widest opacity-50 fw-bold">Practical Approach</p>
                </div>
            </div>
        </div>
    </div>

    <section class="about-home">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <div class="position-relative">
                        <img src="https://img.freepik.com/free-vector/net-income-calculating-abstract-concept-vector-illustration-salary-calculation-net-income-formula-take-home-pay-corporate-accounting-calculating-earnings-profit-estimation-abstract-metaphor_335657-2236.jpg" class="img-fluid about-img" alt="Education">
                        <div class="position-absolute top-0 end-0 m-4 p-4 bg-white rounded-4 shadow-lg animate__animated animate__pulse animate__infinite">
                            <h6 class="fw-900 mb-0 text-primary">New Rules Updated!</h6>
                            <small class="text-muted">GST Council 2026</small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <span class="text-primary fw-900 text-uppercase tracking-widest small">Our Mission</span>
                    <h2 class="fw-900 display-5 mt-3 mb-4">Bridging the Gap <br />Between Theory & Practice.</h2>
                    <p class="text-muted fs-5 mb-5 lh-lg">GST Champions sirf ek portal nahi, Commerce students aur Accountants ke liye ek launchpad hai. Hum law ki complex language ko simplified modules mein translate karte hain.</p>
                    <div class="row g-4 mb-5">
                        <div class="col-6">
                            <div class="d-flex align-items-center"><i class="fas fa-check-circle text-primary me-3 fs-5"></i><span class="fw-800">Filing Mastery</span></div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center"><i class="fas fa-check-circle text-primary me-3 fs-5"></i><span class="fw-800">Audit Skills</span></div>
                        </div>
                    </div>
                    <a href="About.aspx" class="btn btn-dark btn-lg px-5 rounded-4 shadow-lg">Explore</a>
                </div>
            </div>
        </div>
    </section>

    <section class="py-120" style="background: #fdfdff;">
        <div class="container pt-5">
            <div class="text-center mb-5">
                <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill mb-3 fw-bold">CURRICULUM</span>
                <h2 class="fw-900 display-4">Aapka Learning Path</h2>
                <p class="text-muted mx-auto" style="max-width: 500px;">Expert banne ka safar yahan se shuru hota hai.</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="level-card text-center">
                        <div class="icon-circle text-success mx-auto"><i class="fas fa-seedling"></i></div>
                        <h4 class="fw-900 mb-3">01. Basics</h4>
                        <p class="text-muted mb-4">Fundamental GST concepts & Registration process.</p>
                        <a href="Level1.aspx" class="btn btn-link text-primary fw-900 text-decoration-none">Start Now <i class="fas fa-arrow-right ms-2"></i></a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="level-card text-center" style="border-top: 5px solid var(--brand-primary);">
                        <div class="icon-circle text-primary mx-auto"><i class="fas fa-rocket"></i></div>
                        <h4 class="fw-900 mb-3">02. Practical</h4>
                        <p class="text-muted mb-4">GSTR Filing , ITC Claims & Portal workflow.</p>
                        <a href="Level2.aspx" class="btn btn-link text-primary fw-900 text-decoration-none">Go Deep <i class="fas fa-arrow-right ms-2"></i></a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="level-card text-center">
                        <div class="icon-circle text-danger mx-auto"><i class="fas fa-trophy"></i></div>
                        <h4 class="fw-900 mb-3">03. Advanced</h4>
                        <p class="text-muted mb-4">Audit, Assessments, & Dispute resolutions.</p>
                        <a href="Level3.aspx" class="btn btn-link text-primary fw-900 text-decoration-none">Master it <i class="fas fa-arrow-right ms-2"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

   <section class="blog-preview mt-5 pt-5">
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-end mb-5">
            <div>
                <span class="text-primary fw-900 uppercase tracking-widest small">Knowledge Hub</span>
                <h2 class="fw-900 display-6 mt-2">Latest GST Updates</h2>
            </div>
            <a href="KnowledgeHub.aspx" class="btn btn-outline-primary px-4 py-2 rounded-pill fw-bold d-none d-md-block">Explore Hub</a>
        </div>
        <div class="row g-4">
            <asp:Repeater ID="rptLatestBlogs" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4">
                        <div class="card blog-card shadow-sm">
                            <div class="blog-img-container">
                                <img src='admin/uploads/blogs/<%# Eval("ImagePath") %>' class="blog-img" alt="GST Article">
                                <div class="date-badge">
                                    <i class="far fa-calendar-alt me-1 text-primary"></i> <%# Eval("CreatedDate", "{0:dd MMM yyyy}") %>
                                </div>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><%# Eval("Title") %></h5>
                                <p class="short-desc"><%# Eval("ShortDesc") %></p>
                                
                                <hr class="hr-soft" />
                                
                                <a href='BlogDetail.aspx?ID=<%# Eval("BlogID") %>' class="continue-btn">
                                    Continue Reading <i class="fas fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</section>

    <section class="py-120 mt-5 pt-5 pb-5">
        <div class="container">
            <div class="row justify-content-center mb-5">
                <div class="col-lg-7 text-center">
                    <h2 class="fw-900 display-6">Frequently Asked Questions</h2>
                    <p class="text-muted mt-3">GST se jude har bade sawal ka jawab ab ek hi jagah par.</p>
                </div>
            </div>
            <div class="accordion custom-faq" id="faqAccordion">
                <div class="row g-4">
                    <asp:Repeater ID="rptFAQs" runat="server">
                        <ItemTemplate>
                            <div class="col-md-6">
                                <div class="accordion-item shadow-sm">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target='#faq-<%# Eval("FaqID") %>'>
                                            <i class="far fa-question-circle me-3 text-primary"></i> <%# Eval("Question") %>
                                        </button>
                                    </h2>
                                    <div id='faq-<%# Eval("FaqID") %>' class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                        <div class="accordion-body px-5 py-4 text-muted bg-white">
                                            <%# Eval("Answer") %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </section>
</asp:Content>