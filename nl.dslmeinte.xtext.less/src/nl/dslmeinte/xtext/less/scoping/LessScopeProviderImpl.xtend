package nl.dslmeinte.xtext.less.scoping

import com.google.inject.Inject
import nl.dslmeinte.xtext.less.LessLanguageHelper
import nl.dslmeinte.xtext.less.less.LessFile
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.Scopes
import org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider

class LessScopeProviderImpl extends AbstractDeclarativeScopeProvider {

	@Inject
	extension LessLanguageHelper lessLanguageHelper

	// TODO  use my AbstractDeclarateAnnotationBasedScopeProvider here
	def IScope scope_MixinCall_ruleSet(LessFile lessFile, EReference ref) {
		Scopes::scopeFor(lessFile.mixinCandidates, [ it | it.qName ], IScope::NULLSCOPE)
	}

}
