/*
* RUn this code in the console of your browser
*/

function toLatexDataVar (name) {
  return '\\newcommand{\\' + name + 'DATA}{} ' +
    '\\newcommand{\\' + name + '}[1]{\\renewcommand{\\' + name + 'DATA}{#1}} '
}

function createLatexDataVars (arr) {
  var out = ''
  for (var i = 0; i < arr.length; i++) out += toLatexDataVar(arr[i])
  return out
}
var advice = [
  'adviceDate',
  'adviceLocation',
  'adviceMedium',
  'adviceAttendants',
  'adviceMotivation',
  'adviceAgenda',
  'adviceTreated',
  'adviceAdvice'
]
var album = [
  'albumWeekNbr',
  'albumWeekDesc',
  'albumImgDesc',
  'albumImgUrl'
]
var progress = [
  'progressWkNbr',
  'progressMondayDate',
  'progressMo',
  'progressTu',
  'progressWe',
  'progressTh',
  'progressFr',
  'progressGood',
  'progressObstacles',
  'progressTodo',
  'progressReflect',
  'progressFeedback'
]
var retro = [
  'retroSprintNbrAndGoal',
  'retroStoriesGood',
  'retroStoriesCould',
  'retroStoriesImprove',
  'retroScrumGood',
  'retroScrumCould',
  'retroScrumImprove',
  'retroPersonalReflect',
  'retroPersonalFeedback'
]
var story = [
//  'userStoryActor',//using the one from useCase
  'userStoryAction',
  'userStoryResult',
  'userStoryHowToDemo',
  'userStoryEstimatedTime',
  'userStorySpentTime'
]

var useCase = [
  'useCaseSummary',
  'useCaseActors',
  'useCasePrecondition',
  'useCaseDescription',
  'useCaseIntendedFlow',
  'useCaseAlternativeFlow',
//  'useCaseResult',\\using the one from story
  'useCaseImgSrc',
  'useCaseImgWidth'
]
var domain = [
  'domainDescription',
  'domainImgSrc',
  'domainImgWidth'
]
var headings = [
  'hZero',
  'hOne',
  'hTwo',
  'hThree',
  'hFour',
  'hFive',
  'hSix'
]

var allNames = advice
  .concat(album)
  .concat(progress)
  .concat(retro)
  .concat(story)
  .concat(useCase)
  .concat(domain)
  .concat(headings)
createLatexDataVars(allNames)
