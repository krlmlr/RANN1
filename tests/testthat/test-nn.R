context("nn2")

test_that("basic use of nn2", {

  res<-structure(
    list(
      nn.idx = structure(c(1L, 2L, 2L),
                         .Dim = c(3L, 1L)),
      nn.dists = structure(c(0.1, 1, 1.4142135623731),
                           .Dim = c(3L, 1L))),
    .Names = c("nn.idx", "nn.dists"))
  
  res.func<-nn2(rbind(c(1,0),c(2,0)),rbind(c(1.01,0),c(3,0),c(4.0,0)),k=1)
  expect_equal(res,res.func)
  
  a=structure(c(-0.626453810742332, 0.183643324222082, -0.835628612410047, 
                1.59528080213779, 0.329507771815361, -0.820468384118015, 0.487429052428485, 
                0.738324705129217, 0.575781351653492, -0.305388387156356, 1.51178116845085, 
                0.389843236411431, -0.621240580541804, -2.2146998871775, 1.12493091814311, 
                -0.0449336090152309, -0.0161902630989461, 0.94383621068530, 0.821221195098089, 
                0.593901321217509, 0.918977371608218, 0.782136300731067, 0.0745649833651906, 
                -1.98935169586337, 0.61982574789471, -0.0561287395290008, -0.155795506705329, 
                -1.47075238389927, -0.47815005510862, 0.417941560199702), .Dim = c(10L, 
                                                                                   3L))
  
  b=structure(c(1.35867955152904, -0.102787727342996, 0.387671611559369, 
                -0.0538050405829051, -1.37705955682861, -0.41499456329968, -0.394289953710349, 
                -0.0593133967111857, 1.10002537198388, 0.763175748457544, -0.164523596253587, 
                -0.253361680136508, 0.696963375404737, 0.556663198673657, -0.68875569454952, 
                -0.70749515696212, 0.36458196213683, 0.768532924515416, -0.112346212150228, 
                0.881107726454215, 0.398105880367068, -0.612026393250771, 0.341119691424425, 
                -1.12936309608079, 1.43302370170104, 1.98039989850586, -0.367221476466509, 
                -1.04413462631653, 0.569719627442413, -0.135054603880824), .Dim = c(10L, 
                                                                                    3L))
  
  nearest=structure(
    list(
      nn.idx = structure(
        c(7L, 7L, 5L, 8L, 3L, 3L, 10L, 9L, 7L, 9L, 2L, 6L, 10L, 9L, 6L, 2L, 6L, 8L, 2L, 7L, 10L, 3L, 
          2L, 10L, 2L, 10L, 7L, 10L, 5L, 8L, 5L, 9L, 9L, 7L, 10L, 6L, 9L, 
          7L, 10L, 5L, 9L, 10L, 7L, 2L, 1L, 1L, 2L, 5L, 9L, 10L),
        .Dim = c(10L, 5L)),
      nn.dists = structure(c(1.25438639155867, 1.13296914492606, 
                             0.87454984932402, 1.23316343018363, 1.40264207008136, 1.55329441532227, 
                             1.05042085008861, 1.11971763858361, 1.19760903585203, 0.768359537838878, 
                             1.45376527690545, 1.21737684453832, 0.934314680221942, 1.24312406043524, 
                             1.6399895424895, 1.7012465661009, 1.07088129057204, 1.18302964696284, 
                             1.27710147193248, 1.09260495532774, 1.56279510364895, 1.33690357247197, 
                             0.975789442265715, 1.35503731513114, 1.81388787221857, 1.72437263740443, 
                             1.21404991706922, 1.37214532038677, 1.43453854981808, 1.19301186397196, 
                             1.59384634191569, 1.37369148369393, 1.0637844266206, 1.44487201653276, 
                             1.83559536035059, 1.76197730030783, 1.24001577287033, 1.48990092166064, 
                             1.50447311699169, 1.19681724590959, 1.62631452268708, 1.44216213187625, 
                             1.14447642068439, 1.52176467427755, 1.86150179671669, 1.86873168211845, 
                             1.32383999388318, 1.55215319358802, 1.58293433538152, 1.38158123356216
      ),
      .Dim = c(10L, 5L))),
    .Names = c("nn.idx", "nn.dists"))
  
  expect_equal(nn2(a, b, k=5), nearest, tol=1e-6)
})

# NB this fails with the version of ANN distributed with knnFinder v1.0
test_that("nn2 with identical point", {
  res<-structure(
    list(
      nn.idx = structure(c(1L, 2L, 2L),
                         .Dim = c(3L, 1L)),
      nn.dists = structure(c(0, 1, 1.4142135623731),
                           .Dim = c(3L, 1L))),
    .Names = c("nn.idx", "nn.dists"))
	
	res.func<-nn2(rbind(c(1,0),c(2,0)),rbind(c(1.0,0),c(3,0),c(4.0,0)),k=1)
	expect_equal(res,res.func)
})


test_that("nn2 with different search / tree types", {
	set.seed(1)
	a=matrix(rnorm(3000),ncol=3)
	b=matrix(rnorm(3000),ncol=3)
	n.standard<-nn2(a,b,k=5,searchtype='standard')
	n.priority<-nn2(a,b,k=5,searchtype='priority')
	n.bd.standard<-nn2(a,b,k=5,searchtype='standard',treetype='bd')
	n.bd.priority<-nn2(a,b,k=5,searchtype='priority',treetype='bd')

	expect_equal(n.standard,n.priority)
	expect_equal(n.standard,n.bd.standard)
	expect_equal(n.standard,n.bd.priority)
})

test_that("nn2 fixed radius with large radius", {
	set.seed(1)
	a=matrix(rnorm(3000),ncol=3)
	b=matrix(rnorm(3000),ncol=3)
	n.standard<-nn2(a,b,k=5,searchtype='standard')
	n.rad<-nn2(a,b,k=5,searchtype='radius',radius=20.0)
	n.bd.rad<-nn2(a,b,k=5,searchtype='radius',radius=20.0,treetype='bd')

	expect_equal(n.standard,n.rad)
	expect_equal(n.standard,n.bd.rad)
})

test_that("matrix with 0 columns", {
  d=matrix(ncol=0,nrow=90)
  expect_error(nn2(d))
})

test_that("all NA", {
  data=matrix(rnorm(10), ncol=2)
  query=matrix(rep(NA_real_,10), ncol=2)
  expect_error(nn2(data = data, query = query, k=1))
})

test_that("mixture of matrix and vector inputs", {
  mat=matrix(rnorm(10), ncol=1)
  vec=as.numeric(mat)
  expect_is(res<-nn2(data = mat, query = vec, k=1), 'list')
  expect_equal(nn2(data = vec, query = mat, k=1), res)
  expect_equal(nn2(data = vec, query = vec, k=1), res)
})
