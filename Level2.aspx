<%@ Page Title="Level 2: Practical GST Mastery | Returns & Filing Course | GST Champions" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="Level2.aspx.cs" Inherits="Level2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <meta name="description" content="Master practical GST implementation in Level 2. Learn GSTR-1, GSTR-3B filing, ITC reconciliation, and GST portal workflow in Bhilwara. Advance your career with professional tax skills." />
    <meta name="keywords" content="Practical GST Training Bhilwara, Learn GSTR-3B Filing, GST Return Course Rajasthan, ITC Reconciliation Guide, Level 2 GST Professional" />
    <link rel="canonical" href="https://www.gstchampions.in/Level2.aspx" />

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Course",
      "name": "Level 2: Practical GST Mastery",
      "description": "Hands-on training on GST portal navigation, return filing, and input tax credit management for professionals.",
      "provider": {
        "@type": "Organization",
        "name": "GST Champions",
        "url": "https://www.gstchampions.in/"
      },
      "educationalLevel": "Intermediate / Professional",
      "about": ["GSTR-1", "GSTR-3B", "ITC Mismatch", "Portal Navigation"]
    }
    </script>

    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-secondary: #a855f7; 
            --brand-dark: #0f172a;
        }

        /* --- Compact Professional Hero --- */
        .level-hero {
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(99, 102, 241, 0.5)), 
                        url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;
            padding: 100px 0 80px; /* Reduced top and bottom padding */
            color: white;
            text-align: center;
            /*border-radius: 0 0 60px 60px;*/
            position: relative;
            overflow: hidden;
        }

        .level-hero h1 { font-weight: 900; letter-spacing: -2px; font-size: 3rem; }
        
        /* --- Overlapping Glassmorphic Search --- */
        .search-container { 
            margin-top: -65px; 
            margin-bottom: 50px; 
            position: relative; 
            z-index: 20; 
        }
        
        .search-bar { 
            border-radius: 20px; 
            border: 1px solid rgba(255, 255, 255, 0.4); 
            padding: 18px 30px 18px 60px; 
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.12); 
            width: 100%; 
            transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: 1rem;
            font-weight: 600;
        }
        
        .search-bar:focus { 
            outline: none; 
            transform: translateY(-3px);
            border-color: var(--brand-primary); 
            box-shadow: 0 20px 45px rgba(99, 102, 241, 0.2); 
        }

        .search-wrapper { position: relative; }
        .search-wrapper i { 
            position: absolute; 
            left: 25px; 
            top: 50%; 
            transform: translateY(-50%); 
            color: var(--brand-primary);
            font-size: 1.1rem;
            z-index: 21;
        }

        /* --- Professional Topic Cards --- */
        .topic-card {
            border: 1px solid rgba(0,0,0,0.05);
            border-radius: 30px;
            overflow: hidden;
            transition: all 0.4s ease;
            background: white;
            position: relative;
        }

        .topic-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(15, 23, 42, 0.1);
        }

        .topic-card::after {
            content: '';
            position: absolute;
            top: 0; right: 0; width: 80px; height: 80px;
            background: linear-gradient(135deg, transparent 50%, rgba(168, 85, 247, 0.05) 50%);
            border-radius: 0 30px 0 0;
        }
        
        .step-number {
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            color: white;
            width: 45px;
            height: 45px;
            line-height: 45px;
            border-radius: 14px;
            display: inline-block;
            text-align: center;
            font-weight: 800;
            margin-bottom: 20px;
            box-shadow: 0 5px 12px rgba(99, 102, 241, 0.25);
        }

        .topic-title { color: var(--brand-dark); font-weight: 900; letter-spacing: -0.5px; font-size: 1.4rem; }

        .btn-primary {
            background: var(--brand-dark);
            border: none;
            font-weight: 700;
            padding: 10px 22px;
            transition: 0.3s;
            border-radius: 12px;
        }

        .btn-primary:hover {
            background: var(--brand-primary);
            transform: translateX(5px);
        }

        .badge.bg-primary-subtle {
            background-color: #f1f5f9 !important;
            color: var(--brand-primary) !important;
            font-weight: 700;
            border: 1px solid rgba(99, 102, 241, 0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <header class="level-hero animate__animated animate__fadeIn">
        <div class="container">
            <span class="badge bg-warning text-dark px-3 py-2 rounded-pill mb-3 fw-bold animate__animated animate__fadeInDown">STEP 02: PROFESSIONAL</span>
            <h1 class="animate__animated animate__fadeInUp">Level 2: Practical Mastery</h1>
            <p class="lead opacity-75 mx-auto mb-4" style="max-width: 600px;">Real-world GST scenarios, portal navigation, aur practical filings seekhein.</p>
        </div>
    </header>

    <div class="container py-5">
        <div class="row search-container justify-content-center">
            <div class="col-md-7 search-wrapper">
                <i class="fas fa-search"></i>
                <input type="text" id="topicSearch" class="search-bar" placeholder="Dhundiye GSTR-1, 3B, ITC mismatch, etc..." onkeyup="searchFunction()">
            </div>
        </div>

        <div class="row g-4" id="topicList">
            <asp:Repeater ID="rptTopics" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4 topic-item" data-aos="fade-up">
                        <div class="topic-card h-100 p-4 d-flex flex-column shadow-sm">
                            <div class="step-number shadow-sm">#<%# Container.ItemIndex + 1 %></div>
                            <h4 class="topic-title mb-3"><%# Eval("TopicName") %></h4>
                            <p class="text-muted flex-grow-1" style="line-height: 1.6; font-size: 0.95rem;">Is topic mein aap seekhenge portal par kaam kaise kiya jata hai aur returns kaise file hote hain.</p>
                            
                            <hr class="my-4 opacity-10" />
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="badge bg-primary-subtle rounded-pill px-3 py-2">
                                    <i class="fas fa-briefcase me-1"></i> Practical
                                </span>
                                <a href='LessonDetail.aspx?TopicID=<%# Eval("TopicID") %>' class="btn btn-primary shadow-sm">
                                    Read <i class="fas fa-play ms-2 small"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            <asp:PlaceHolder ID="phNoData" runat="server" Visible="false">
                <div class="col-12 text-center py-5">
                    <div class="mb-4 opacity-25">
                         <i class="fas fa-tools fa-5x text-muted"></i>
                    </div>
                    <h4 class="fw-900 text-muted">Karyashala Taiyaar Ho Rahi Hai</h4>
                    <p class="text-muted">Jald hi yahan practical topics upload kiye jayenge.</p>
                </div>
            </asp:PlaceHolder>

            <div id="noResults" class="col-12 text-center py-5" style="display:none;">
                <div class="mb-4 opacity-25">
                         <i class="fas fa-search fa-5x text-muted"></i>
                </div>
                <h4 class="fw-900 text-muted">Afsos! Aisa koi topic nahi mila.</h4>
                <p class="text-muted">Try keyword like 'GSTR' or 'ITC'.</p>
            </div>
        </div>
    </div>

    <script>
        function searchFunction() {
            var input = document.getElementById('topicSearch');
            var filter = input.value.toLowerCase();
            var nodes = document.getElementsByClassName('topic-item');
            var foundCount = 0;

            for (i = 0; i < nodes.length; i++) {
                // Topic name se match karein
                var title = nodes[i].querySelector('.topic-title').innerText.toLowerCase();
                if (title.includes(filter)) {
                    nodes[i].style.display = "";
                    foundCount++;
                } else {
                    nodes[i].style.display = "none";
                }
            }

            // Agar koi result nahi milta toh message dikhao
            var noResults = document.getElementById('noResults');
            if (foundCount === 0 && filter !== "") {
                noResults.style.display = "block";
            } else {
                noResults.style.display = "none";
            }
        }
    </script>

    </asp:Content>