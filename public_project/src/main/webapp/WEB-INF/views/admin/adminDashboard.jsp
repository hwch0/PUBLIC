<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" href="/plugins/icheck-bootstrap/icheck-bootstrap.min.css"/> -->
<link rel="stylesheet" href="/plugins/chart.js/Chart.css"/>
<script src="/plugins/chart.js/Chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  
  
<style>
.chartjs-render-monitor {
	max-height: 300px!important;
}
</style>
  
    
 <div class="admin_dash">
<div class="dashboard" style="padding: 20px 100px 20px 100px">


<!--  <!-- Info boxes -->
<!--             <div class="row"> -->
<!--               <div class="col-12 col-sm-6 col-md-3"> -->
<!--                 <div class="info-box"> -->
<!--                   <span class="info-box-icon bg-info elevation-1" -->
<!--                     ><i class="fas fa-cog"></i -->
<!--                   ></span> -->

<!--                   <div class="info-box-content"> -->
<!--                     <span class="info-box-text">CPU Traffic</span> -->
<!--                     <span class="info-box-number"> -->
<!--                       10 -->
<!--                       <small>%</small> -->
<!--                     </span> -->
<!--                   </div> -->
<!--                   /.info-box-content -->
<!--                 </div> -->
<!--                 /.info-box -->
<!--               </div> -->
<!--               /.col -->
<!--               <div class="col-12 col-sm-6 col-md-3"> -->
<!--                 <div class="info-box mb-3"> -->
<!--                   <span class="info-box-icon bg-danger elevation-1" -->
<!--                     ><i class="fas fa-thumbs-up"></i -->
<!--                   ></span> -->

<!--                   <div class="info-box-content"> -->
<!--                     <span class="info-box-text">Likes</span> -->
<!--                     <span class="info-box-number">41,410</span> -->
<!--                   </div> -->
<!--                   /.info-box-content -->
<!--                 </div> -->
<!--                 /.info-box -->
<!--               </div> -->
<!--               /.col -->

<!--               fix for small devices only -->
<!--               <div class="clearfix hidden-md-up"></div> -->

<!--               <div class="col-12 col-sm-6 col-md-3"> -->
<!--                 <div class="info-box mb-3"> -->
<!--                   <span class="info-box-icon bg-success elevation-1" -->
<!--                     ><i class="fas fa-shopping-cart"></i -->
<!--                   ></span> -->

<!--                   <div class="info-box-content"> -->
<!--                     <span class="info-box-text">Sales</span> -->
<!--                     <span class="info-box-number">760</span> -->
<!--                   </div> -->
<!--                   /.info-box-content -->
<!--                 </div> -->
<!--                 /.info-box -->
<!--               </div> -->
<!--               /.col -->
<!--               <div class="col-12 col-sm-6 col-md-3"> -->
<!--                 <div class="info-box mb-3"> -->
<!--                   <span class="info-box-icon bg-warning elevation-1" -->
<!--                     ><i class="fas fa-users"></i -->
<!--                   ></span> -->

<!--                   <div class="info-box-content"> -->
<!--                     <span class="info-box-text">New Members</span> -->
<!--                     <span class="info-box-number">2,000</span> -->
<!--                   </div> -->
<!--                   /.info-box-content -->
<!--                 </div> -->
<!--                 /.info-box -->
<!--               </div> -->
<!--               /.col -->
<!--             </div> -->
<!--             /.row -->

<!-- 
<!-- <!--  -->
<!--       Small boxes (Stat box) -->
      <div class="row">
        <div class="col-lg-3 col-6">
          <!-- small box -->
          <div class="small-box bg-info">
            <div class="inner">
              <h3 class="data">150<span style="font-size:20px;"> 명</span></h3>

              <p>전일 사용자</p>
            </div>
            <div class="icon">
              <i class="ion ion-person"></i>
            </div>
          </div>
        </div>
        
<!--         ./col -->
        <div class="col-lg-3 col-6">
<!--           small box -->
          <div class="small-box bg-success">
            <div class="inner">
              <h3 class="data">150<span style="font-size:20px;"> 명</span></h3>

              <p>금일 사용자</p>
            </div>
            <div class="icon">
              <i class="ion ion-person-add"></i>
            </div>
          </div>
        </div>
        
<!--         ./col -->
        <div class="col-lg-3 col-6">
<!--           small box -->
          <div class="small-box bg-warning">
            <div class="inner">
              <h3 class="data lastMonthSalse">150<span style="font-size:20px;"> 백만원</span></h3>

              <p>전월 매출</p>
            </div>
            <div class="icon">
              <i class="ion ion-stats-bars"></i>
            </div>
          </div>
        </div>
<!--         ./col -->
        <div class="col-lg-3 col-6">
<!--           small box -->
          <div class="small-box bg-danger">
            <div class="inner">
              <h3 class="data thisMonthSalse">150<span style="font-size:20px;"> 백만원</span></h3>

              <p>금월 매출</p>
            </div>
            <div class="icon">
              <i class="ion ion-pie-graph"></i>
            </div>
          </div>
        </div>
      </div>
<!--       /.row -->
      
      
      <div class="row">
          <div class="col-8">
            <!-- interactive chart -->
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="far fa-chart-bar"></i>
                  Interactive Area Chart
                </h3>

                <div class="card-tools">
                  Real time
                  <div class="btn-group" id="realtime" data-toggle="btn-toggle">
                    <button type="button" class="btn btn-default btn-sm active" data-toggle="on">On</button>
                    <button type="button" class="btn btn-default btn-sm" data-toggle="off">Off</button>
                  </div>
                </div>
              </div>
              <div class="card-body">
                <div id="interactive" style="height: 200px;">
                <canvas class="flot-base" style="direction: ltr; position: absolute; left: 0px; top: 0px; width: 100%; height: 200px;"></canvas>
                <canvas class="flot-overlay" style="direction: ltr; position: absolute; left: 0px; top: 0px; width: 100%; height: 200	px;"></canvas>
                <div  class="flot-svg" style="position: absolute; top: 0px; left: 0px; height: 100%; width: 100%; pointer-events: none;">
                	<svg style="width: 100%; height: 100%;"></svg>
                </div>
                
              </div>
              <!-- /.card-body-->
            </div>
            <!-- /.card -->

          </div>
          </div>
          <!-- /.col -->
          
           <div class="col-4">
            <!-- pie chart -->
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="far fa-chart-bar"></i>
                  Interactive Area Chart
                </h3>
              </div>
              <div class="card-body">
 					<canvas
                      id="pieChart"
                      style="
                        min-height: 200px;
                        height: 200px;
                        max-height: 200px;
                        max-width: 100%;
                      "
                    ></canvas>
            </div>
            <!-- /.card -->

          </div>
        </div>
       </div> <!-- /.row -->
      
      <div class="row">
        <div class="col-md-6">
          <!-- STACKED BAR CHART -->
          <div class="card card-success">
            <div class="card-header">
              <h3 class="card-title">Monthly Sales</h3>

              <div class="card-tools">
                <button
                  type="button"
                  class="btn btn-tool"
                  data-card-widget="collapse"
                >
                  <i class="fas fa-minus"></i>
                </button>
                <button
                  type="button"
                  class="btn btn-tool"
                  data-card-widget="remove"
                >
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
            <div class="card-body">
              <div class="chart">
                <canvas
                  id="stackedBarChart"
                  style="
                    min-height: 200px;
                    height: 200px;
                    max-height: 200px;
                    max-width: 100%;
                  "
                ></canvas>
              </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>

        <div class="col-md-6">
          <!-- LINE CHART -->

          <div class="card card-info">
            <div class="card-header">
              <h3 class="card-title">Users Timeline</h3>

              <div class="card-tools">
                <button
                  type="button"
                  class="btn btn-tool"
                  data-card-widget="collapse"
                >
                  <i class="fas fa-minus"></i>
                </button>
                <button
                  type="button"
                  class="btn btn-tool"
                  data-card-widget="remove"
                >
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
            <div class="card-body">
              <div class="chart">
                <canvas
                  id="lineChart"
                  style="
                    min-height: 200px;
                    height: 200px;
                    max-height: 200px;
                    max-width: 100%;
                  "
                ></canvas>
              </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
      </div>
      <!-- /.card -->
    </div>
    <!-- /.dashboard -->
 
 
 
 </div>

<!-- jQuery Mapael -->
<script src="/plugins/jquery-mousewheel/jquery.mousewheel.js"></script>
<script src="/plugins/raphael/raphael.min.js"></script>

<!-- <!-- FLOT CHARTS -->
<script src="/plugins/flot/jquery.flot.js"></script>
<script src="/plugins/flot/plugins/jquery.flot.resize.js"></script>
<script src="/plugins/flot/plugins/jquery.flot.pie.js"></script> 
    
